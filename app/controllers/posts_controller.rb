class PostsController < ApplicationController
  inherit_resources
  actions :index, :show
  def editor_newsletter
    @editors = Post.editors_active
  end
  def chesca_trends
    @trends = Post.trends_active
  end
  def archived_looks
    @looks = Post.looks_active
  end
  def index
    page = params[:page] || 1
    per_page = 10
    @posts = Post.paginate(:order => 'created_at DESC',:page=>page,:per_page=>per_page)
    index!
  end
end
