require 'test_helper'

class TerrinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @terrin = terrins(:one)
  end

  test "should get index" do
    get terrins_url
    assert_response :success
  end

  test "should get new" do
    get new_terrin_url
    assert_response :success
  end

  test "should create terrin" do
    assert_difference('Terrin.count') do
      post terrins_url, params: { terrin: { terrid: @terrin.terrid } }
    end

    assert_redirected_to terrin_url(Terrin.last)
  end

  test "should show terrin" do
    get terrin_url(@terrin)
    assert_response :success
  end

  test "should get edit" do
    get edit_terrin_url(@terrin)
    assert_response :success
  end

  test "should update terrin" do
    patch terrin_url(@terrin), params: { terrin: { terrid: @terrin.terrid } }
    assert_redirected_to terrin_url(@terrin)
  end

  test "should destroy terrin" do
    assert_difference('Terrin.count', -1) do
      delete terrin_url(@terrin)
    end

    assert_redirected_to terrins_url
  end
end
