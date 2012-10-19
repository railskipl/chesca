class Admin::ColorsController < Admin::AdminController
  inherit_resources
  actions :all, :except => :show
  def index
    @colors = Color.all
    @new_color = Color.new
  end
  def create
    create! {admin_colors_path}
  end
  def update
    update! {admin_colors_path}
  end
end
