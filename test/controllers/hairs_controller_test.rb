require "test_helper"

class HairsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hairs_index_url
    assert_response :success
  end

  test "should get show" do
    get hairs_show_url
    assert_response :success
  end

  test "should get new" do
    get hairs_new_url
    assert_response :success
  end

  test "should get create" do
    get hairs_create_url
    assert_response :success
  end

  test "should get edit" do
    get hairs_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get hairs_destroy_url
    assert_response :success
  end
end
