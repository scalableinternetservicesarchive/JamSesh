require 'rails_helper'
require 'devise'

RSpec.describe JamGroupsController, type: :controller do
  fixtures :all
  login_user

  before(:each) do
    @jam_group = jam_groups(:one)
  end

  it "should get index" do
    get :index
    assert_response :success
  end

  it "should get new" do
    get :new
    assert_response :success
  end

  it "should create jam_group" do
    count = JamGroup.count
    post :create, params: { jam_group: {name: 'Name', image_url:'', description: ''} }
    expect(JamGroup.count).to be(count + 1)

    expect(response).to redirect_to(jam_group_url(JamGroup.last))
  end

  it "should show jam_group" do
    get :show, params: { id: @jam_group.id }
    assert_response :success
  end

  it "should get edit" do
    get :edit, params: { id: @jam_group.id }
    assert_response :success
  end

  it "should update jam_group" do
    patch :update, params: { id: @jam_group.id, jam_group: {name: 'Name', image_url:'', description: ''} } 

    expect(response).to redirect_to(jam_group_url(@jam_group))
  end

  it "should destroy jam_group" do
    expect { 
      delete :destroy, params: { id: @jam_group, force_delete: 'true' }
    }.to change(JamGroup, :count).by(-1)
    
    expect(response).to redirect_to(jam_groups_url)
  end
end
