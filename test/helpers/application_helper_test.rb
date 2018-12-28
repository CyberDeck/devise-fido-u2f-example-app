class UserHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "gravatar" do
    user = users(:user)
 
    assert_dom_equal '<span aria-hidden="true"><img alt="user@example.com" class="gravatar" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user)
  end

  test "gravatar with tooltip" do
    user = users(:user)
 
    assert_dom_equal '<span aria-hidden="true"><img alt="user@example.com" class="gravatar" rel="tooltip" title="Test" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user, tooltip: "Test")
  end

  test "gravatar with id" do
    user = users(:user)
 
    assert_dom_equal '<span aria-hidden="true"><img alt="user@example.com" class="gravatar" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user, id: 1337)
  end
end
