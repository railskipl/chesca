class LooksController < ApplicationController
  inherit_resources
  actions :index, :show
  
  def archived_looks
    @looks = Look.active.all(:order => 'created_at DESC')
  end

  def index
    page = params[:page] || 1
    per_page = 1
    @looks = Look.paginate(:order => 'created_at DESC',:page=>page,:per_page=>per_page)
    index!
  end
  
  def show
    @look = Look.find(params[:id])
  end
end

