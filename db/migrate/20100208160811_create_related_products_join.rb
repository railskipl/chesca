class CreateRelatedProductsJoin < ActiveRecord::Migration
  def self.up
    create_table 'products_products', :id => false do |t|
      t.integer :product_id
      t.integer :related_product_id
    end
  end
  def self.down
    drop_table 'products_products'
  end
end
