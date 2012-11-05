class CreateRelatedProductColors < ActiveRecord::Migration
  def self.up
    create_table :related_product_colors do |t|
      t.integer :product_id
      t.integer :product_image_id

      t.timestamps
    end
  end

  def self.down
    drop_table :related_product_colors
  end
end
