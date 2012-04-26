require 'test_helper'

class DesignersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Designer.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Designer.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Designer.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to designer_url(assigns(:designer))
  end

  def test_edit
    get :edit, :id => Designer.first
    assert_template 'edit'
  end

  def test_update_invalid
    Designer.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Designer.first
    assert_template 'edit'
  end

  def test_update_valid
    Designer.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Designer.first
    assert_redirected_to designer_url(assigns(:designer))
  end

  def test_destroy
    designer = Designer.first
    delete :destroy, :id => designer
    assert_redirected_to designers_url
    assert !Designer.exists?(designer.id)
  end
end
