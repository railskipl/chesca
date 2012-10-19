class DesignersController < ApplicationController
  #before_filter :build_meta, :only => [:index, :show]
  def index
    @designers =  Designer.all
  end
  def show
    params[:page] ||= 1
    order_by = "#{params[:sort_by] ||= "position"} #{params[:order] ||= 'ASC'}"
    option = {:order => order_by}
    designer = Designer.find(params[:id])
    option[:conditions] = {:designer_id => designer.id} unless params[:id].blank?
    @products = products_scope.fetch_page(params[:page],option)
    @meta_title = @products[0].department.name rescue @meta_title= nil
    @meta_description = @products[0].department.description rescue @meta_defaults = nil
    @meta_keywords = @products[0].department.keywords rescue @meta_keywords = nil
    @designers =  Designer.all
    render 'products/index'
  end
end
