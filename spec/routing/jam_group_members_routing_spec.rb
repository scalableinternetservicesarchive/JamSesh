require "rails_helper"

RSpec.describe JamGroupMembersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/jam_group_members").to route_to("jam_group_members#index")
    end

    it "routes to #new" do
      expect(:get => "/jam_group_members/new").to route_to("jam_group_members#new")
    end

    it "routes to #show" do
      expect(:get => "/jam_group_members/1").to route_to("jam_group_members#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/jam_group_members/1/edit").to route_to("jam_group_members#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/jam_group_members").to route_to("jam_group_members#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/jam_group_members/1").to route_to("jam_group_members#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/jam_group_members/1").to route_to("jam_group_members#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/jam_group_members/1").to route_to("jam_group_members#destroy", :id => "1")
    end

  end
end
