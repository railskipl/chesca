class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.references :cart, :product, :size
      t.string :product_name
      t.string :product_code
      t.integer :product_price, :precision => 8, :scale => 2
      t.integer :quantity

      t.timestamps
    end

    add_index :cart_items, :cart_id
  end

  def self.down
    drop_table :cart_items
  end
end
