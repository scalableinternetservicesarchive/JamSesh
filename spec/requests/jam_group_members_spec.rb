require 'rails_helper'

RSpec.describe "JamGroupMembers", type: :request do
  describe "GET /jam_group_members" do
    it "works! (now write some real specs)" do
      FactoryGirl.create_list(:jam_group_member, 5)
      get jam_group_members_path
      expect(response).to have_http_status(200)
    end
  end
end
