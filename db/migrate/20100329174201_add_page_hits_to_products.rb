class AddPageHitsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :page_hits, :integer, :default => 0
  end

  def self.down
    remove_column :products, :page_hits
  end
end
