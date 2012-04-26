class AddDisplayOrderToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :display_order, :integer
  end

  def self.down
    remove_column :products, :display_order
  end
end
