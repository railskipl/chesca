class AddProductSizeeIdToProductImage < ActiveRecord::Migration
  def self.up
    add_column :product_images, :product_size_id, :integer
  end

  def self.down
    remove_column :product_images, :product_size_id
  end
end
