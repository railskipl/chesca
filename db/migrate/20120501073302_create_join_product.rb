class CreateJoinProduct < ActiveRecord::Migration
  def self.up
     create_table 'related_products', :id => false do |t|
      t.integer :product_id
      t.integer :related_product_id
  end

  def self.down
    drop_table 'related_products'
  end
  end
end
