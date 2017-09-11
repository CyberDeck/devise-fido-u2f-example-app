class UserHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "should return the user's full name" do
    user = users(:user)
 
    assert_dom_equal '<div id="glyph-gravatar-b58996c504c5638798eb6b511e6f49af" class="box-gravatar"><span class="glyphicon glyphicon-user glyph-gravatar" aria-hidden="true" /></div><span style="display:none" id="gravatar-gravatar-b58996c504c5638798eb6b511e6f49af" aria-hidden="true"><img alt="user@example.com" class="gravatar" onload="javascript: $(\'#glyph-gravatar-b58996c504c5638798eb6b511e6f49af\').hide(); $(\'#gravatar-gravatar-b58996c504c5638798eb6b511e6f49af\').show();" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user)
  end
end
