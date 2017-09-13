class UserHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "gravatar" do
    user = users(:user)
 
    assert_dom_equal '<div id="glyph-gravatar-b58996c504c5638798eb6b511e6f49af-0" class="box-gravatar"><span class="glyphicon glyphicon-user glyph-gravatar-0" aria-hidden="true" /></div><span style="display:none" id="gravatar-gravatar-b58996c504c5638798eb6b511e6f49af-0" aria-hidden="true"><img alt="user@example.com" class="gravatar" onload="javascript: $(\'#glyph-gravatar-b58996c504c5638798eb6b511e6f49af-0\').hide(); $(\'#gravatar-gravatar-b58996c504c5638798eb6b511e6f49af-0\').show();" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user)
  end

  test "gravatar with tooltip" do
    user = users(:user)
 
    assert_dom_equal '<div id="glyph-gravatar-b58996c504c5638798eb6b511e6f49af-0" class="box-gravatar"><span class="glyphicon glyphicon-user glyph-gravatar-0" aria-hidden="true" /></div><span style="display:none" id="gravatar-gravatar-b58996c504c5638798eb6b511e6f49af-0" aria-hidden="true"><img alt="user@example.com" class="gravatar" onload="javascript: $(\'#glyph-gravatar-b58996c504c5638798eb6b511e6f49af-0\').hide(); $(\'#gravatar-gravatar-b58996c504c5638798eb6b511e6f49af-0\').show();" rel="tooltip" title="Test" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user, tooltip: "Test")
  end

  test "gravatar with id" do
    user = users(:user)
 
    assert_dom_equal '<div id="glyph-gravatar-b58996c504c5638798eb6b511e6f49af-1337" class="box-gravatar"><span class="glyphicon glyphicon-user glyph-gravatar-1337" aria-hidden="true" /></div><span style="display:none" id="gravatar-gravatar-b58996c504c5638798eb6b511e6f49af-1337" aria-hidden="true"><img alt="user@example.com" class="gravatar" onload="javascript: $(\'#glyph-gravatar-b58996c504c5638798eb6b511e6f49af-1337\').hide(); $(\'#gravatar-gravatar-b58996c504c5638798eb6b511e6f49af-1337\').show();" src="https://secure.gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?d=404" /></span>', gravatar_for(user, id: 1337)
  end
end
