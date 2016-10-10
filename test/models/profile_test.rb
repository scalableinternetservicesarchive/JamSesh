require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def setup
    @profile1 = Profile.new()
    @profile2 = Profile.new(location: "UCSB")
  end
  
  test "valid user" do
    assert @profile1.valid?
  end
  
  test "correct location" do
    assert @profile2.location == "UCSB"
  end
  
end
