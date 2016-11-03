require 'rails_helper'

RSpec.describe "jam_group_members/edit", type: :view do
  before(:each) do
    @jam_group_member = assign(:jam_group_member, JamGroupMember.create!())
  end

  it "renders the edit jam_group_member form" do
    render

    assert_select "form[action=?][method=?]", jam_group_member_path(@jam_group_member), "post" do
    end
  end
end
