require 'test_helper'

class CompanyPagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_page" do
    assert_difference('CompanyPage.count') do
      post :create, :company_page => { }
    end

    assert_redirected_to company_page_path(assigns(:company_page))
  end

  test "should show company_page" do
    get :show, :id => company_pages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => company_pages(:one).to_param
    assert_response :success
  end

  test "should update company_page" do
    put :update, :id => company_pages(:one).to_param, :company_page => { }
    assert_redirected_to company_page_path(assigns(:company_page))
  end

  test "should destroy company_page" do
    assert_difference('CompanyPage.count', -1) do
      delete :destroy, :id => company_pages(:one).to_param
    end

    assert_redirected_to company_pages_path
  end
end
