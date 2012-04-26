class ChangePriceColumn < ActiveRecord::Migration
  def self.up
    change_column(:cart_items, :product_price,:float, :precision => 8, :scale => 2)
  end

  def self.down
    change_column(:cart_items, :product_price,:integer, :precision => 8, :scale => 2)
  end
end
