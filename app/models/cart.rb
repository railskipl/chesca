class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :delete_all

  belongs_to :voucher, :counter_cache => true
  belongs_to :giftcard
  cattr_accessor :delivery_options,:free_delivery
  attr_protected :delivery_option
  serialize :delivery_option
  @@free_delivery = {:id=>:free_UK, :description => "Free Delivery in the UK for orders over £150",:price=> 0,:unit=>"Euro"}
  @@delivery_options = [
    {:id=>:next_day, :description => "UK",:price=> ENV['next_day'].to_f,:unit=>"Euro"}, #6.5
    {:id=>:euro_ireland, :description => "Ireland",:price=> ENV['euro_ireland'].to_f,:unit=>"Euro"}, # 10
    {:id=>:euro_mainland, :description => "Europe",:price=> ENV['euro_mainland'].to_f,:unit=>"Euro"}, # 15
    {:id=>:austratia, :description => "Rest of World",:price=> ENV['austratia'].to_f,:unit=>"Euro"}#15,

  ]
  
  
  def product_is_not_repeted(prod)
   self.cart_items.each do |i|
      if i.product_id == prod.id
        false
        break
      else
        true
      end
    end
  end
  def before_save
    self.selected_delivery_option= :free_UK if free_delivery? and delivery_options.nil?
  end
  
  # Total (without discounts)
  def gross_total
    cart_items.all.sum(&:subtotal)
  end
  
  def checks_valid_gift_card_code(code)
    # if self.giftcard.exists?
      # false
    # else
       gift = Giftcard.find_by_name(code) if self.giftcard.nil?
         unless gift.nil?
            gift.update_attribute(:usage_count, gift.usage_count + 1)
            self.update_attribute(:giftcard_id, gift.id)
            true
         else
            false
         end
    # end
  end
  
    # Gift Card Value Select.
  def discount
    voucher ? voucher.apply(gross_total) : 0
  end

  def delivery_charges
    delivery_option[:price].to_f rescue 0
  end
  
  def delivery_charges_in_cents
    (delivery_charges * 100)#delivery_option[:price] rescue 0
  end
  
  def discount_in_cents
    (discount * 100).to_i
  end

  # Net total (with discount applied)
  def total
    gross_total - discount - (!self.giftcard.nil? ? self.giftcard.value : 0) + (has_valid_delivery_option? ? delivery_charges : 0)
  end

  def total_in_cents
    (total * 100)
  end

  def has_valid_delivery_option?
    return free_delivery?  if delivery_option and delivery_option[:id] =='free_UK'.to_sym#&& delivery_charges == 0
    delivery_charges ? (delivery_charges!=0) : false
  end

  def free_delivery?
    gross_total >= 150
  end

  def to_payment_details
    # Collect items in cart
    details = cart_items.map do |item|
      {
        :name        => item.name_with_size,
        :number      => item.product_code,
        :amount      => item.product_price_in_cents,
        :quantity    => item.quantity,
        :description => item.human_size
      }
    end

    # Add discount as a negative-price item if present
    if voucher
      details << {
        :name        => voucher.description,
        :number      => voucher.code,
        :amount      => -discount_in_cents,
        :quantity    => 1,
        :description => 'Voucher'
      }
    end
    
    if has_valid_delivery_option? and delivery_charges!=0
      details << {
        :name => "Delivery Charges",
        :number => 000000,
        :amount => delivery_charges_in_cents,
        :quantity => 1,
        :description => delivery_option[:description]
      }  end


    Rails.logger.debug(details.inspect)

    details
  end

  def selected_delivery_option= opt_key
    if opt_key.nil?
      self.delivery_option = Cart.delivery_options[0]
    elsif opt_key.to_sym==:free_UK
      self.delivery_option = self.class.free_delivery
    else
      option = self.delivery_options.select{|opt| opt[:id]==opt_key.to_sym}
      raise("invalid delivery option") if option.empty?
      self.delivery_option = option.first
    end
  end

  def selected_delivery_option
    return nil unless delivery_option
    delivery_option
  end

  def update_product_stock
    cart_items.each do |item|
      item.product.reduce_stock( item.quantity)
    end
  end

  def voucher_code
    voucher ? voucher.code : nil
  end

end
