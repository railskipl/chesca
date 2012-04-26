class AddColoridToProductSize < ActiveRecord::Migration
  def self.up
    add_column :product_sizes, :color_id, :integer
  end

  def self.down
    remove_column :product_sizes, :color_id
  end
end
