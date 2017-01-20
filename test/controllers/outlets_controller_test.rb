require 'test_helper'

class OutletsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @outlet = outlets(:one)
  end

  test "should get index" do
    get outlets_url
    assert_response :success
  end

  test "should get new" do
    get new_outlet_url
    assert_response :success
  end

  test "should create outlet" do
    assert_difference('Outlet.count') do
      post outlets_url, params: { outlet: {  } }
    end

    assert_redirected_to outlet_url(Outlet.last)
  end

  test "should show outlet" do
    get outlet_url(@outlet)
    assert_response :success
  end

  test "should get edit" do
    get edit_outlet_url(@outlet)
    assert_response :success
  end

  test "should update outlet" do
    patch outlet_url(@outlet), params: { outlet: {  } }
    assert_redirected_to outlet_url(@outlet)
  end

  test "should destroy outlet" do
    assert_difference('Outlet.count', -1) do
      delete outlet_url(@outlet)
    end

    assert_redirected_to outlets_url
  end
end
