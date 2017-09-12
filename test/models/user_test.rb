require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
  end

  test "should be valid" do
    assert @user.valid?
  end  

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = " "*10
    @user.password_confirmation = " "*10
    assert_not @user.valid?
  end
  
  test "password should be not to long" do
    @user.password = "x"*129
    @user.password_confirmation = "x"*129
    assert_not @user.valid?
  end

  test "password should be not to short" do
    @user.password = "x"*5
    @user.password_confirmation = "x"*5
    assert_not @user.valid?
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
