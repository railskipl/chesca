class Admin::DesignersController < Admin::AdminController
  inherit_resources
  actions:all, :except => :show
  def index
    @designers = Designer.all
    @new_designer = Designer.new
  end
  def create
    create! {admin_designers_path}
  end
  def update
    update! {admin_designers_path}
  end
end
