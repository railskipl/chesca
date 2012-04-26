class AddOldPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :old_price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :products, :old_price
  end
end
