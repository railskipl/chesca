require 'test_helper'

class Admin::DepartmentsControllerTest < ActionController::TestCase
  context 'as an unauthenticated user' do
    setup do
      log_out
    end

    context 'on GET to :index' do
      setup do
        get :index
      end

      should_set_the_flash_to 'You must login first!'
      should_redirect_to('the login page') { new_admin_session_url }
    end

    context 'on POST to :create' do
      setup do
        post :create, :department => { :name => 'A test department' }
      end

      should_set_the_flash_to 'You must login first!'
      should_redirect_to('the login page') { new_admin_session_url }
    end
  end

  context 'when logged in as an administrator' do
    setup do
      log_in_as_admin
    end

    context 'on GET to :index' do
      setup do
        get :index
      end

      should_respond_with :ok
    end

    context 'on POST to :create' do
      setup do
        post :create, :department => { :name => 'A test department' }
      end

      should_redirect_to('the departments index page') { admin_departments_url }
    end

    context 'on POST to :create with missing data' do
      setup do
        @department_count = Department.count
        post :create
      end

      should 'not create the department' do
        assert_equal @department_count, Department.count
      end

      should_respond_with :ok
    end
  end
end
