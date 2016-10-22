require 'rails_helper'

RSpec.describe "jam_group_members/new", type: :view do
  before(:each) do
    assign(:jam_group_member, JamGroupMember.new())
  end

  it "renders new jam_group_member form" do
    render

    assert_select "form[action=?][method=?]", jam_group_members_path, "post" do
    end
  end
end
