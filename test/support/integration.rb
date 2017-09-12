require 'action_dispatch/testing/integration'

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  def teardown
    Capybara.reset_sessions!
    super
  end

  # Add more helper methods to be used by all tests here...
  def assert_translations
    assert_no_selector 'span.translation_missing'
    assert_no_text 'translation missing:'
  end

  def assert_basic_links(signed_in: false, user: nil)
    within "header" do
      assert_link 'Home', href: root_path
      if signed_in
        assert_no_link 'Sign in', href: new_user_session_path
        assert_no_link 'Register', href: new_user_registration_path
        assert_link 'Sign out', href: destroy_user_session_path
        # Gravatar is not loaded during test and thus not visible
        assert_selector "a[href='#{edit_user_registration_path}'] img", visible: false 
      else
        assert_link 'Sign in', href: new_user_session_path
        assert_link 'Register', href: new_user_registration_path
        assert_no_link 'Sign out', href: destroy_user_session_path
        assert_no_selector "a[href='#{edit_user_registration_path}'] img", visible: false 
      end
    end
  end
  def set_hidden_field(name, value)
    page.find("input[name=#{name}]", visible: false).set(value)
  end

  def submit_form!(locator)
    form = page.find(locator)
    class << form
      def submit!
        Capybara::RackTest::Form.new(driver, native).submit({})
      end
    end
    form.submit!
  end

  def javascript_parser
    @parser ||= RKelly::Parser.new
  end

  def find_ast_for_variable_assignment(ast, variable)
    ast.each do |node| 
      if node.class == RKelly::Nodes::VarStatementNode 
        node.each do |var| 
          if var.class == RKelly::Nodes::VarDeclNode
            if var.name == variable
              return var.value
            end
          end
        end
      end
    end
    return nil
  end

  def find_javascript_assignment_for_array(page, variable)
    page.all('body script', visible: false).each do |el|
      ast = javascript_parser.parse(el.text(:all))
      assignment = find_ast_for_variable_assignment(ast, variable)
      if assignment.first.class == RKelly::Nodes::AssignExprNode
        value = assignment.first.value
        return JSON.parse(value.to_ecma)
      end
    end
    return nil
  end

  def find_javascript_assignment_for_string(page, variable)
    page.all('body script', visible: false).each do |el|
      ast = javascript_parser.parse(el.text(:all))
      assignment = find_ast_for_variable_assignment(ast, variable)
      if assignment.first.class == RKelly::Nodes::AssignExprNode
        value = assignment.first.value
        str = value.value
        return str[1..-2] if str.chr == "'"
        return str[1..-2] if str.chr == '"'
        return "Unknown"
      end
    end
    return nil
  end

  def create_user(options={})
    @user ||= begin
      user = User.create!(
        email: options[:email] || 'user@test.com',
        password: options[:password] || '12345678',
        password_confirmation: options[:password] || '12345678',
        created_at: Time.now.utc
      )
      user.lock_access! if options[:locked] == true
      create_u2f_device(user, options[:usf_device][:key_handle], options[:usf_device][:public_key], options[:usf_device][:certificate]) if options[:usf_device]
      user
    end
  end

  def sign_in_as_user(options={}, &block)
    visit_with_option options[:visit], new_user_session_path
    within 'div[id="sign-in"] form' do
      fill_in 'Email', with: options[:email] || 'user@example.com'
      fill_in 'Password', with: options[:password] || 'abcdefgh'
      check 'Remember me' if options[:remember_me] == true
      yield if block_given?
      click_button 
    end
  end

  protected

    def visit_with_option(given, default)
      case given
      when String
        visit given
      when FalseClass
        # Do nothing
      else
        visit default
      end
    end
end
