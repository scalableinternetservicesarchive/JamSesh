require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user1 = User.new(email: "user@example.com", password: "123456")
    @user2 = User.new(email: "user@example.com", password: "12345")
    @user3= User.new(email: "usexample", password: "123456")
  end

  it "should validate users" do
    expect(@user1.valid?).to be(true)
  end
  
  it "should know if password is too short" do
    expect(@user2.valid?).to be(false)
  end
  
  it "should detect invalid emails" do
    expect(@user3.valid?).to be(false)
  end
end
