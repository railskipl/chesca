class AddDeliveryOptionToCart < ActiveRecord::Migration
  def self.up
     add_column :carts, :delivery_option, :string
  end

  def self.down
    remove_column :carts, :delivery_option
  end
end
