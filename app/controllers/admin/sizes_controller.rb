class Admin::SizesController < Admin::AdminController
  inherit_resources

  def index
    @new_size = Size.new
    index!
  end

  def create
    @new_size = Size.new(params[:size])

    respond_to do |format|
      if @new_size.save
        format.html { redirect_to admin_sizes_url}
      else
        format.html { render action => "new" }
      end
    end
  end
  
end
