class StylesController < ApplicationController
  before_filter :build_meta, :only => [:index, :show]
  include StylesHelper
  def show
    params[:page] ||= 1
    parent_style = Style.find(params[:id])
    array_children = all_children(parent_style)
    conditions = { :style_id => array_children }
    conditions.merge!({:department_id=>params[:department].to_i}) unless params[:department].blank?
    @products = products_scope.fetch_page(params[:page], :order => 'created_at DESC', :conditions => conditions)
    @is_admin = admin? ? true  : false
    @meta_title = @products[0].style.name rescue @meta_title = nil
    @meta_description = @products[0].style.description rescue @meta_description = nil
    @meta_keywords = @products[0].style.keywords rescue @meta_keywords = nil
    render 'products/index'
  end

  def build_meta
    resource = Style.find(params[:id])
    @meta_title = resource.name
    @fb_meta[:title] = resource.name
  end
end

