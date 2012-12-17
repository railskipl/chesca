class ProductImage < ActiveRecord::Base
  has_attached_file :image, :styles => { :square => '60x60#', :tiny => '89x125>', :small => '185x260>', :medium => '375x525>', :large => '650x912>' },
  :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "public/system/product_images/:id/:style/:basename.:extension"
  before_save :check_if_main_image
  before_save :make_main_image_unique
  #after_save :check
  belongs_to :product_size
  #has_many :related_product_colors

private
  def check
    if ProductImage.all.size > 0
      #flash[:notice] = 'aumento el numero de imagenes'
    else
      #flash[:notice]= 'nada!!'
    end
  end
  # Make this the main image if there's no other main image for the same product
  def check_if_main_image
    self.main_image = self.class.count(:conditions => {:main_image => true, :product_id => product_id}).zero?
    # Since callbacks can cancel saving, return true to prevent it
    true
  end

  # Make sure we don't have any other main images for this product
  def make_main_image_unique
    self.class.update_all({:main_image => false}, ['product_id = ? AND id != ?', product_id, id])
  end
end
