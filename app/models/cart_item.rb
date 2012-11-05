class CartItem < ActiveRecord::Base
  #validates_presence_of :color, :size, :quantity
  belongs_to :cart, :counter_cache => true
  belongs_to :product
  has_one :product_image, :through => :product, :conditions => {:main_image => true}

  before_create :copy_product_properties
  before_create :check_already_existing

  attr_protected :product_name, :product_price, :product_code

  def subtotal
    product_price * quantity
  end

  def product_price_in_cents
    (product_price * 100) || 0
  end

  def name_with_size
    "#{product_name} (#{human_size})"
  end

  def human_size
    "Size #{size}"
  end
    
  #def product_price_in_cents(discount = 0)
  #  ((product_price * ((100 - discount)/100.0)) * 100).to_i
  #end

private

  def copy_product_properties
    self.product_name = product.name
    self.product_code = "#{product.code}#{Color.find_by_name(self.color).id}" 
    self.product_price = product.price
  end

  def check_already_existing
    if existing_cart_item = cart.cart_items.find(:first, :conditions => {:product_id => product_id, :size => size, :color => self.color})
      existing_cart_item.update_attribute(:quantity, existing_cart_item.quantity + quantity)
      return false
    end
  end
  
end
