class Admin::ProductImagesController < Admin::AdminController
  layout false

  inherit_resources

  belongs_to :product, :optional => true

  #actions :all, :except =>

  def show
    render(:partial => 'product_image', :object => resource)
  end

  def create
    @product_image = ProductImage.new(params[:product_image])
    #puts "************************************************#{@product_image}"
    create! do |success, failure|
      success.html { render }
      failure.html { head(:bad_request) }
    end
    flash[:notice] = nil
  end
   
  def destroy
    resource.destroy
    head(:ok)
  end
end