class AddColorProductIdToProductImage < ActiveRecord::Migration
  def self.up
    add_column :product_images, :color_product_id, :integer
  end

  def self.down
    add_column :product_images, :color_product_id, :integer
  end
end
