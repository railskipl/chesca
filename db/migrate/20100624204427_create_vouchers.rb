class CreateVouchers < ActiveRecord::Migration
  def self.up
    create_table :vouchers do |t|
      t.string :code
      t.integer :carts_count, :default => 0
      t.integer :percent, :default => 0
      t.datetime :date_expired

      t.timestamps
    end

    add_column :carts, :voucher_id, :integer, :default => 0
    
  end

  def self.down
    drop_table :vouchers

    remove_column :carts, :voucher_id
  end
end
