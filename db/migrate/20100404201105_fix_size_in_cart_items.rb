class FixSizeInCartItems < ActiveRecord::Migration
  def self.up
    change_table :cart_items do |t|
      t.remove :size_id
      t.string :size
    end
  end

  def self.down
    change_table :cart_items do |t|
      t.remove :size
      t.integer :size_id
    end
  end
end
