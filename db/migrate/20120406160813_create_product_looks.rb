class CreateProductLooks < ActiveRecord::Migration
  def self.up
    create_table :product_looks do |t|
      t.integer :product_id, :null => false
      t.integer :look_id, :null => false
    end
  end

  def self.down
    drop_table :product_looks
  end
end
