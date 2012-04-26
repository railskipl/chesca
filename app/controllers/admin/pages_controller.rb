class Admin::PagesController < Admin::AdminController
  inherit_resources
  # actions :all, :except => :show
  defaults :route_prefix => 'admin'
  before_filter :init_all_products, :only => [:create, :new, :edit, :update]

  def create
    create! { admin_pages_url }
  end

  def update
    update! { admin_pages_url }
  end

  private
  def init_all_products
    @all_products = Product.all
  end
end
