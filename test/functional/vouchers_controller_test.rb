require 'test_helper'

class VouchersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vouchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create voucher" do
    assert_difference('Voucher.count') do
      post :create, :voucher => { }
    end

    assert_redirected_to voucher_path(assigns(:voucher))
  end

  test "should show voucher" do
    get :show, :id => vouchers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => vouchers(:one).to_param
    assert_response :success
  end

  test "should update voucher" do
    put :update, :id => vouchers(:one).to_param, :voucher => { }
    assert_redirected_to voucher_path(assigns(:voucher))
  end

  test "should destroy voucher" do
    assert_difference('Voucher.count', -1) do
      delete :destroy, :id => vouchers(:one).to_param
    end

    assert_redirected_to vouchers_path
  end
end
