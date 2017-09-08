require 'test_helper'

class TerroutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @terrout = terrouts(:one)
  end

  test "should get index" do
    get terrouts_url
    assert_response :success
  end

  test "should get new" do
    get new_terrout_url
    assert_response :success
  end

  test "should create terrout" do
    assert_difference('Terrout.count') do
      post terrouts_url, params: { terrout: { datedue: @terrout.datedue, dateout: @terrout.dateout, publisher: @terrout.publisher, terrid: @terrout.terrid } }
    end

    assert_redirected_to terrout_url(Terrout.last)
  end

  test "should show terrout" do
    get terrout_url(@terrout)
    assert_response :success
  end

  test "should get edit" do
    get edit_terrout_url(@terrout)
    assert_response :success
  end

  test "should update terrout" do
    patch terrout_url(@terrout), params: { terrout: { datedue: @terrout.datedue, dateout: @terrout.dateout, publisher: @terrout.publisher, terrid: @terrout.terrid } }
    assert_redirected_to terrout_url(@terrout)
  end

  test "should destroy terrout" do
    assert_difference('Terrout.count', -1) do
      delete terrout_url(@terrout)
    end

    assert_redirected_to terrouts_url
  end
end
