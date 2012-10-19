class AddStockLevelToProduct < ActiveRecord::Migration
  def self.up
    add_column :products,:stock_level, :integer,:default=>0
  end

  def self.down
    remove_column( :products,:stock_level)
  end
end
