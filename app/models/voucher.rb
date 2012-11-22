class Voucher < ActiveRecord::Base
  named_scope :date_active, :conditions => ['start_date_promotion <= ? AND end_date_promotion >= ?',Date.today,Date.today]
  has_many :carts
  has_many :products_voucher
  has_many :products, :through => :products_voucher, :class_name => "Product"

  #validates_presence_of :code
  #validates_format_of :code, :with => /\A[\w-]+\Z/
  #validates_uniqueness_of :code
  #validates_numericality_of :percent, :only_integer => true, :greater_than => 0, :less_than_or_equal_to => 100

  def coefficient
    percent / 100.0
  end

  def apply(apply_to)
    apply_to * coefficient
  end

  def description
    "#{percent}% Discount"
  end
  
  def self.all_vouchers
    self.with_exclusive_scope{find(:all)}
  end
end
