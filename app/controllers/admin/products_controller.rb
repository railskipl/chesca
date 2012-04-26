class Admin::ProductsController < Admin::AdminController
  inherit_resources
  actions :all, :except => :show
  before_filter :fetch_departments_and_styles, :only => [:index, :new, :edit]
  def display_order
    @products = products_scope.all

    if request.post?
      products_scope.all.each { |product| product.update_attributes(:display_order => params[:display_order][product.id.to_s].to_i) }

      redirect_to display_order_admin_products_url
    end
  end
  def top100
    @products = products_scope.all(:order => 'page_hits DESC', :limit => 100, :include => :department)
  end
  def index
    # index!
    order_by = case params[:sort_by]
    when 'name'
      then 'products.name ASC'
    when 'created_at'
      then "products.created_at ASC"
    when 'department'
      then 'departments.name ASC'
    when 'style'
      then "styles.name ASC"
    else
      'products.name ASC'
    end
    @products = Product.all(:include => [:department, :style],:order=>order_by)

    respond_to do |format|
      format.html
      format.csv do
        Rails.logger.debug request.protocol

        generated_csv = FasterCSV.generate do |csv|
          csv << ["Product ID", "Name", "Deeplink", "Category", "Price", "Image URL", "Description", "Thumbnail Image URL", "Brand/Manufacturer"]

          @products.each do |p|
            csv << [
              p.code,
              p.name,
              product_url(p),
              p.department.try(:name),
              p.price,
              p.main_image && (request.protocol + request.host_with_port + p.main_image.image.url(:original, false)),
              p.description.try(:strip),
              p.main_image && (request.protocol + request.host_with_port + p.main_image.image.url(:tiny, false)),
              'Chesca'
            ]
          end
        end
        send_data generated_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=products.csv"
      end
    end
  end
  def new
    @colors = Color.all
    @sizes = Size.all
    @designers = Designer.all
    @all_other_products = products_scope.all
    new!
  end
  def edit
    @colors = Color.all
    @sizes = Size.all
    @new_product_image = ProductImage.new
    @designers = Designer.all
    @all_other_products = products_scope.all - [resource]
    edit!
  end

  def create
    params_to_sizes
    create! { admin_products_url }
  end
  def update
    params[:product][:related_product_ids] ||= []
    params[:product][:product_look_ids] ||=[]
    params[:product][:complete_outfit_ids] ||=[]
    params_to_sizes
    update! { admin_products_url }
  end
  def in_place_edit
    product = Product.find(params[:id])
    product[params['field']] = params['value']
    product.save
   render :text=> product[params['field']] and return
  end
  #antiguo
  def addimages
    @new_product_image = ProductImage.new
    @product_size = ProductSize.find(:first, :conditions => ["color_id = ? && product_id = ? && size_id = ?",params[:locals][:color],params[:locals][:product],params[:locals][:size]] )
  end
  def addimagessave
  end
  private
  def fetch_departments_and_styles
    @departments = Department.all #it is category
    @styles = Style.all # it is boutique
    @looks =Look.all
  end
  def params_to_sizes
    product_id = Product.find(params[:id]).id rescue product_id = nil
    if product_id
      params[:size_stock].each do |s|
        params[:size_stock][s[0]].each do |css|
          unless css[1].empty?
            ps = ProductSize.find_by_color_id_and_size_id(css[0],s[0])
            if ps
              ps.stock_level = css[1].to_i
            else
              ps=  ProductSize.new({:product_id =>product_id ,:size_id=> s[0], :stock_level=>css[1].to_i, :color_id => css[0]})
            end
            ps.save
          else
            ps = ProductSize.find_by_color_id_and_size_id(css[0],s[0])
            if ps
              if !ps.product_images.empty?
                ps.stock_level= 0
                ps.save
              else
                ps.destroy
              end
            end
          end
        end
      end
    end
  end
end
