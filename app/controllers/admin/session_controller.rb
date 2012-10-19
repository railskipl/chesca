class Admin::SessionController < Admin::AdminController
  skip_before_filter :require_authentication, :only => [:new, :create]

  layout 'application'

  def new
  end

  def create
    if params[:password] == ADMIN_PASSWORD
      session[:admin] = true
    else
      flash[:error] = 'Wrong login'
    end

    redirect_to_back_or_default
  end

  def destroy
    session[:admin] = nil
    redirect_to(root_url)
  end
end
