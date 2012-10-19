class AddAmountOffToVoucher < ActiveRecord::Migration
  def self.up
    add_column :vouchers, :amount_off, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :vouchers, :amount_off
  end
end
