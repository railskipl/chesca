class RemoveColorProductIdFromProductImage < ActiveRecord::Migration
  def self.up
    remove_column :product_images, :color_product_id
  end

  def self.down
    add_column :product_images, :color_product_id
  end
end
