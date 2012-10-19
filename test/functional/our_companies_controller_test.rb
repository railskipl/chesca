require 'test_helper'

class OurCompaniesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => OurCompany.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    OurCompany.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    OurCompany.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to our_company_url(assigns(:our_company))
  end

  def test_edit
    get :edit, :id => OurCompany.first
    assert_template 'edit'
  end

  def test_update_invalid
    OurCompany.any_instance.stubs(:valid?).returns(false)
    put :update, :id => OurCompany.first
    assert_template 'edit'
  end

  def test_update_valid
    OurCompany.any_instance.stubs(:valid?).returns(true)
    put :update, :id => OurCompany.first
    assert_redirected_to our_company_url(assigns(:our_company))
  end

  def test_destroy
    our_company = OurCompany.first
    delete :destroy, :id => our_company
    assert_redirected_to our_companies_url
    assert !OurCompany.exists?(our_company.id)
  end
end
