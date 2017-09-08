require 'test_helper'

class DncsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dnc = dncs(:one)
  end

  test "should get index" do
    get dncs_url
    assert_response :success
  end

  test "should get new" do
    get new_dnc_url
    assert_response :success
  end

  test "should create dnc" do
    assert_difference('Dnc.count') do
      post dncs_url, params: { dnc: { date: @dnc.date, name: @dnc.name, notes: @dnc.notes, number: @dnc.number, publisher: @dnc.publisher, street: @dnc.street, terrid: @dnc.terrid } }
    end

    assert_redirected_to dnc_url(Dnc.last)
  end

  test "should show dnc" do
    get dnc_url(@dnc)
    assert_response :success
  end

  test "should get edit" do
    get edit_dnc_url(@dnc)
    assert_response :success
  end

  test "should update dnc" do
    patch dnc_url(@dnc), params: { dnc: { date: @dnc.date, name: @dnc.name, notes: @dnc.notes, number: @dnc.number, publisher: @dnc.publisher, street: @dnc.street, terrid: @dnc.terrid } }
    assert_redirected_to dnc_url(@dnc)
  end

  test "should destroy dnc" do
    assert_difference('Dnc.count', -1) do
      delete dnc_url(@dnc)
    end

    assert_redirected_to dncs_url
  end
end
