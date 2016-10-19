require 'test_helper'

class JamGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jam_group = jam_groups(:one)
  end

  test "should get index" do
    get jam_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_jam_group_url
    assert_response :success
  end

  test "should create jam_group" do
    assert_difference('JamGroup.count') do
      post jam_groups_url, params: { jam_group: {  } }
    end

    assert_redirected_to jam_group_url(JamGroup.last)
  end

  test "should show jam_group" do
    get jam_group_url(@jam_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_jam_group_url(@jam_group)
    assert_response :success
  end

  test "should update jam_group" do
    patch jam_group_url(@jam_group), params: { jam_group: {  } }
    assert_redirected_to jam_group_url(@jam_group)
  end

  test "should destroy jam_group" do
    assert_difference('JamGroup.count', -1) do
      delete jam_group_url(@jam_group)
    end

    assert_redirected_to jam_groups_url
  end
end
