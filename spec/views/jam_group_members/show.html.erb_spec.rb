require 'rails_helper'

RSpec.describe "jam_group_members/show", type: :view do
  before(:each) do
    @jam_group_member = assign(:jam_group_member, JamGroupMember.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
