class CreateProductsVouchers < ActiveRecord::Migration
  def self.up
    create_table :products_vouchers, :id => false do |t|
      t.integer :product_id
      t.integer :voucher_id

      t.timestamps
    end
  end
  def self.down
    drop_table :products_vouchers
  end
end
