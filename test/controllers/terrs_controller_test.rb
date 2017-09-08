require 'test_helper'

class TerrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @terr = terrs(:one)
  end

  test "should get index" do
    get terrs_url
    assert_response :success
  end

  test "should get new" do
    get new_terr_url
    assert_response :success
  end

  test "should create terr" do
    assert_difference('Terr.count') do
      post terrs_url, params: { terr: { datecomp: @terr.datecomp, history: @terr.history, name: @terr.name, notes: @terr.notes, region: @terr.region } }
    end

    assert_redirected_to terr_url(Terr.last)
  end

  test "should show terr" do
    get terr_url(@terr)
    assert_response :success
  end

  test "should get edit" do
    get edit_terr_url(@terr)
    assert_response :success
  end

  test "should update terr" do
    patch terr_url(@terr), params: { terr: { datecomp: @terr.datecomp, history: @terr.history, name: @terr.name, notes: @terr.notes, region: @terr.region } }
    assert_redirected_to terr_url(@terr)
  end

  test "should destroy terr" do
    assert_difference('Terr.count', -1) do
      delete terr_url(@terr)
    end

    assert_redirected_to terrs_url
  end
end
