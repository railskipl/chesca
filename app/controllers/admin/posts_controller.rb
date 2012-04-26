class Admin::PostsController < Admin::AdminController
  inherit_resources
  actions :all
  def index
      @editors = Post.editors
      @trends = Post.trends
      @looks = Post.looks
    index!
  end
  def new
    @post = Post.new
    case params[:type]
    when '1'
      then @post.type_post =  'Editors Newsletter'
    when '2'
      then @post.type_post = 'Chesca Trends'
    when '3'
      then @post.type_post = 'Archived Looks'
    end
  end
end

