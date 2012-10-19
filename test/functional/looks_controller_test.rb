require 'test_helper'

class LooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:looks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create look" do
    assert_difference('Look.count') do
      post :create, :look => { }
    end

    assert_redirected_to look_path(assigns(:look))
  end

  test "should show look" do
    get :show, :id => looks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => looks(:one).to_param
    assert_response :success
  end

  test "should update look" do
    put :update, :id => looks(:one).to_param, :look => { }
    assert_redirected_to look_path(assigns(:look))
  end

  test "should destroy look" do
    assert_difference('Look.count', -1) do
      delete :destroy, :id => looks(:one).to_param
    end

    assert_redirected_to looks_path
  end
end
