require 'rails_helper'

RSpec.describe Profile, :type => :model do 
  before(:each) do
    @profile1 = Profile.new()
    @profile2 = Profile.new(location: "UCSB")
  end
  
  it "should validate profiles" do
    assert @profile1.valid?
  end
  
  it "should be able to access location" do
    assert @profile2.location == "UCSB"
  end
  
end
