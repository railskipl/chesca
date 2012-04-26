class Admin::LocationsController < Admin::AdminController
  def index
    @addresses = Address.all
    @locations = Location.all
  end

  def new
    @location = Location.new
    @address = Address.new
  end

  def create
    if params[:address]
      @object = Address.new(params[:address])
    end
    if params[:location]
      @object = Location.new(params[:location])
    end
    if @object.save
      redirect_to admin_locations_url
    else
      render :action => 'new'
    end
  end

  def edit
    if params[:model] == "Address"
      @address = Address.find(params[:id])
    elsif params[:model] == "Location"
      @location = Location.find(params[:id])
    end
  end

  def destroy
    if params[:model] == "Address"
      @location = Address.find(params[:id])
    elsif params[:model] == "Location"
      @location = Location.find(params[:id])
    end
    @location.destroy
    redirect_to admin_locations_url
  end

  def update
    if params[:address]
      @object = Address.find(params[:id])
      @object.update_attributes(params[:address])
    elsif params[:location]
      @object = Location.find(params[:id])
      @object.update_attributes(params[:location])
    end
    flash[:notice] = "Updated sucessfully"
     redirect_to admin_locations_url
  end
end

