class ProductsController < ApplicationController
  inherit_resources
  actions :show
  before_filter :build_new_cart_item, :only => [:index, :show]
  before_filter :build_meta, :only => [:index, :show]
  before_filter :increment_page_hits, :only => :show
  before_filter :set_default_page, :only => [:index, :sales, :new_arrivals]
  
  def show
    if params[:id] != "undefined"
      @product = Product.find(params[:id])
    end
  end
  
  def index
    @meta_title = "Products Home"
    if !params[:search].blank?
      @products = products_scope.search params[:page], params[:search]
      @meta_keywords = @products.map(&:name).join(",")
      flash.now[:notice] = "Search results - #{@products.total_entries} item(s) found."
    else
      redirect_to root_url
    end
  end
  
  def sales
    @meta_title = "Product Sales"
    @products = products_scope.sales.fetch_page params[:page]
    @meta_keywords = @products.map(&:name).join(",")
    render 'index'
  end
  
  def new_arrivals
    @meta_title = "New Arrivals"
    @products = products_scope.new_arrivals params[:page]
    @meta_keywords = @products.map(&:name).join(",")
    render 'index'
  end
  
  def send_to_a_friend
    if validate_mailer_params(params[:mailer])
      Mailer.deliver_send_to_a_friend(params[:mailer][:name], params[:mailer][:email], params[:mailer][:friends_email], Product.find(params[:mailer][:product_id]))
      flash[:notice] = 'Your recommendation has been sent.'
    end
    redirect_to product_path(params[:mailer][:product_id])
  end
  
  private
  def set_default_page
    params[:page] ||= 1
  end
  
  def validate_mailer_params(params)
    params.values.all? { |param| !param.blank? } && valid_name?(params[:name]) && valid_email_address?(params[:email]) && valid_email_address?(params[:friends_email])
  end
  
  def build_new_cart_item
    @new_cart_item = CartItem.new
  end
  
  def increment_page_hits
    if params[:id] != "undefined"
      Product.update(params[:id], :page_hits => resource.page_hits + 1)
    end
  end
  
  def build_meta
    @meta_title = resource.name
    @meta_description = resource.description
    @fb_meta[:title] = resource.name
    @fb_meta[:description] = resource.description
    @fb_meta[:image] =    resource.main_image.image.url(:small_fixed) if resource.main_image
  rescue
  end

end
