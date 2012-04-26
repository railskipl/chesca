class OrderAddSource < ActiveRecord::Migration
  def self.up
    add_column :orders, :source,:string
  end

  def self.down
    remove_column :orders, :source
  end
end
