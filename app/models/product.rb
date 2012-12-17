# Product model
# Prices are saved as integers representing cents to avoid rounding errors
class Product < ActiveRecord::Base
  acts_as_list
  cattr_reader :per_page
  @@per_page = 32
  # has_attached_file :photo, 
     # :styles => { :small => "150x150>" },
     # :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
     # :path => "public/system/photos/:id/:style/:basename.:extension"

    # validates_attachment_presence :photo
    # validates_attachment_size :photo, :less_than => 5.megabytes
    # validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  #validates_presence_of :name
  #validates_presence_of :code
  #validates_presence_of :departments_id, :departments_name
  belongs_to :department #new name is Shop by category
  belongs_to :style #new name is Boutique
  has_and_belongs_to_many :related_colors, :join_table => 'related_product_colors', :association_foreign_key => 'related_color_id',:uniq => true, :class_name => 'Product', :after_add => :add_inverse_color, :after_remove => :remove_inverse_color, :conditions => { :visible => true }
  #has_many :product_images, :dependent => :destroy
  has_one :main_image, :class_name => 'ProductImage', :conditions => {:main_image => true} 
  
  has_and_belongs_to_many :related_products,  :join_table => 'products_products',:class_name => 'Product', :association_foreign_key => 'related_product_id',:uniq => true, :after_add => :add_inverse_outfit, :after_remove => :remove_inverse_outfit, :conditions => { :visible => true }

  has_and_belongs_to_many :complete_outfits,  :join_table => 'products_products_outfits',:class_name => 'Product', :association_foreign_key => 'complete_outfit_id',:uniq => true, :after_add => :add_inverse_outfit, :after_remove => :remove_inverse_outfit, :conditions => { :visible => true }


  has_many :product_outfits, :foreign_key => 'product_id', :class_name => 'ProductOutfit'
  has_many :outfits, :through => :product_outfits

  default_scope :order => 'products.created_at DESC, products.position ASC'

  named_scope :visible, :conditions => { :visible => true }
  named_scope :sales, :conditions => "price < old_price"

  has_many :sizes, :through => :product_sizes
  has_many :product_sizes
  accepts_nested_attributes_for :product_sizes
  has_many :colors, :through => :product_sizes
  has_many :product_images, :dependent => :destroy       #, :through => :product_sizes

  has_many :products_voucher
  has_many :vouchers, :through => :products_voucher, :class_name => "Voucher"
  belongs_to :designer

  def self.fetch_page(page, *args)
    options = { :page => page }
    args.each { |arg| options.merge!(arg) }
    paginate options
  end
  
  def self.new_arrivals(page)
    with_exclusive_scope(:find => { :order => 'created_at DESC' }) do
      fetch_page page, :total_entries => 32
    end
  end

  def self.search(page, search)
    options = { :page => page }
    Product.name_or_description_or_department_name_like_all(search.split(" ")).paginate(options)
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def reduced_price?
    !old_price.blank? && (price < old_price)
  end

  def reduce_stock(count=1)
#    raise("stock count can not be greater than #{stock_level}") if (stock_level - count) < 0
    self.stock_level = (stock_level - count)
    save
  end

  def increase_stock(count=1)
    self.stock_level = (stock_level + count)
    save
  end

  def self.count_by_dep_and_style(dep_id, style_id, isAdmin=false)
    sql = ["select count(*) from products where products.department_id = ? AND products.style_id = ? ",dep_id,style_id]
    unless isAdmin
      sql[0] << "AND visible = ?"
      sql << true
    end
    count_by_sql(sql)
  end

  def size_stock_level size
    product_sizes.find_by_size_id(size.id).stock_level #rescue nil
  end

protected
  def add_inverse(product)
    product.related_products << self unless product.related_products.include?(self)
  end

  def remove_inverse(product)
    product.related_products.delete(self) if product.related_products.include?(self)
  end
  
  def add_inverse_outfit(product)
    product.complete_outfits << self unless product.complete_outfits.include?(self)
  end

  def remove_inverse_outfit(product)
    product.complete_outfits.delete(self) if product.complete_outfits.include?(self)
  end
  
  def add_inverse_color(product)
    product.related_colors << self unless product.related_colors.include?(self)
  end
  
  def remove_inverse_color(product)
    product.related_colors.delete(self) if product.related_colors.include?(self)
  end
end
