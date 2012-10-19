class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :cart_items_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
