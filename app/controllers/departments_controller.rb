class DepartmentsController < ApplicationController
  before_filter :build_meta, :only => [:index, :show]
  include DepartmentsHelper
  def show
    params[:page] ||= 1
    order_by = "#{params[:sort_by] ||= 'created_at'} #{params[:order] ||= 'DESC'}"
    option = {:order => order_by}
    parent_category = Department.find(params[:id])
    array_children = all_children(parent_category)
    option[:conditions] = { :department_id => array_children} unless params[:id].blank?
    @products = products_scope.fetch_page(params[:page],option)
    @meta_title = @products[0].department.name rescue @meta_title= nil
    @meta_description = @products[0].department.description rescue @meta_defaults = nil
    @meta_keywords = @products[0].department.keywords rescue @meta_keywords = nil
    render 'products/index'
  end


  def build_meta
    resource = Department.find(params[:id])
    @meta_title = resource.name
    @fb_meta[:title] = resource.name
  end
end

