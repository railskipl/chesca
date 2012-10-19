class AddDatesPromotionToVoucher < ActiveRecord::Migration
  def self.up
    add_column :vouchers, :start_date_promotion, :datetime
    add_column :vouchers, :end_date_promotion, :datetime
  end

  def self.down
    remove_column :vouchers, :end_date_promotion
    remove_column :vouchers, :start_date_promotion
  end
end
