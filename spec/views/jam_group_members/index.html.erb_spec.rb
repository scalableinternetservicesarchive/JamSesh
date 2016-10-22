require 'rails_helper'

RSpec.describe "jam_group_members/index", type: :view do
  before(:each) do
    assign(:jam_group_members, [
      FactoryGirl.create(:jam_group_member),
      FactoryGirl.create(:jam_group_member)
    ])
  end

  it "renders a list of jam_group_members" do
    render
  end
end
