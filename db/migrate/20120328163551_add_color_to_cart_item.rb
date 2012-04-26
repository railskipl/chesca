class AddColorToCartItem < ActiveRecord::Migration
  def self.up
    add_column :cart_items, :color, :string
  end

  def self.down
    remove_column :cart_items, :color
  end
end
