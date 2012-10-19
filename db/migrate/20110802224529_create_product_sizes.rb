class CreateProductSizes < ActiveRecord::Migration
  def self.up
    create_table :product_sizes do |t|
      t.integer :product_id, :null => false
      t.integer :size_id, :null => false
      t.integer :stock_level, :default => 0
      t.timestamps
    end
    ProductSize.re_create_size
  end

  def self.down
    drop_table :product_sizes
  end
end