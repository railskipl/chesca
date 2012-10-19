class ProductCompleteOutfit < ActiveRecord::Migration
  def self.up
    create_table 'products_products_outfits', :id => false do |t|
      t.integer :product_id
      t.integer :complete_outfit_id
    end
  end

  def self.down
    drop_table 'products_products_outfits'
  end
end
