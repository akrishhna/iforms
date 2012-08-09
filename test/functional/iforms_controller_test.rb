require 'test_helper'

class IformsControllerTest < ActionController::TestCase
  setup do
    @iform = iforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:iforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create iform" do
    assert_difference('Iform.count') do
      post :create, :iform => @iform.attributes
    end

    assert_redirected_to iform_path(assigns(:iform))
  end

  test "should show iform" do
    get :show, :id => @iform.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @iform.to_param
    assert_response :success
  end

  test "should update iform" do
    put :update, :id => @iform.to_param, :iform => @iform.attributes
    assert_redirected_to iform_path(assigns(:iform))
  end

  test "should destroy iform" do
    assert_difference('Iform.count', -1) do
      delete :destroy, :id => @iform.to_param
    end

    assert_redirected_to iforms_path
  end
end
