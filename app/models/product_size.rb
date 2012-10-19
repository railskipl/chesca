class ProductSize < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
  belongs_to :color
  has_many :product_images

  #validates_numericality_of :stock_level,:allow_nil => true, :allow_blank => true

  def self.image_main(color,size,product_id)
      size =Size.find_by_name(size).id #rescue size = nil
      color =Color.find_by_name(color).id #rescue color = nil
      product_id = Product.find_by_name(product_id).id 
      if !size.nil? && !color.nil?
        product_size = ProductSize.find_by_color_id_and_size_id_and_product_id(color,size,product_id)
        if product_size
          images = product_size.product_images
          if !images.empty?
            return images.first
          end
        else
          return nil
        end
      else
        return nil
      end
  end
  def self.sizes_for_product(product)
    if product.code.start_with?('8')
      if product.name.match(/\d/)
        return [5, 6, 7, 8]
      else
        return ['Only one size']
      end
    elsif product.code.start_with?('4')
      return [1, 2, 3, 4]
    end
    [12, 13, 14, 15]
  end

  def self.re_create_size
    
  end
end
