require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user1 = User.new(email: "user@example.com", password: "123456")
    @user2 = User.new(email: "user@example.com", password: "12345")
    @user3= User.new(email: "usexample", password: "123456")
  end

  test "valid user" do
    assert @user1.valid?
  end
  
  test "password too short" do
    assert_not @user2.valid?
  end
  
  test "invalid email" do
    assert_not @user3.valid?
  end
end