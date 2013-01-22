class PostsController < ApplicationController
   layout "pinkapplication"
  inherit_resources
  actions :index, :show
  
  def archived_looks
    @looks = Post.looks_active.all(:order => 'created_at DESC')
  end
  def index
    page = params[:page] || 1
    per_page = 3
    @posts = Post.paginate(:order => 'created_at DESC',:page=>page,:per_page=>per_page)
    index!
  end
end
