# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # FIXME: This was causing crashes when using IE7...
  # Ideally I'd like to figure out what was going wrong
  # exactly and fix it, but since this was preventing
  # sales I didn't have time for that... maybe later?
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :admin?, :current_cart

  before_filter :fetch_departments_and_styles, :create_cookie, :meta_defaults
  after_filter :persist_session_cart

  def products_scope
    admin? ? Product : Product.visible
  end
  
  protected
  
  def create_cookie
    unless  params[:source].nil?
      cookies['source'] = { :value => params[:source], :expires => 32.days.from_now}
      @render_cookie = true
    end
  end
  
  def valid_name?(name)
    name.match(/^[a-záéíóúàèìòùñçâêîôûäëïöü' ]+$/i)
  end
  
  def valid_email_address?(email_address)
    email_address.match(/^[a-z0-9_\-.]+?@[a-z0-9][a-z0-9\-.]+[a-z0-9]\.[a-z]{2,4}$/)
  end

  private

  def fetch_departments_and_styles
    @departments = Department.all
    @styles = Style.all
    @feeds= NewsFeed.active
    @looks = Look.all
  end

  def current_cart
    @current_cart ||= if session[:cart_id]
      Cart.find(session[:cart_id])
    else
      Cart.new
    end
  end
  
  def persist_session_cart
    if @current_cart && !@current_cart.new_record?
      session[:cart_id] = @current_cart.id
    end
  end

  def destroy_session_cart
    @current_cart = nil
    session[:cart_id] = nil
  end

  def admin?
    session[:admin]
  end

  def require_authentication
    unless admin?
      flash[:notice] = 'You must login first!'
      session[:return_to] = request.request_uri
      redirect_to(new_admin_session_url)
    end
  end

  def redirect_to_back_or_default(default = root_url)
    redirect_to(session[:return_to] || default)
  end

  def meta_defaults
    @meta_title =  nil
    @meta_keywords = nil
    @meta_description = nil
    @fb_meta = {}
  end
  
end
