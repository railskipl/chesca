class Admin::SizesController < Admin::AdminController
  inherit_resources

  def index
    @new_size = Size.new
    index!
  end

  def create
    create! { admin_sizes_url }
  end
end
