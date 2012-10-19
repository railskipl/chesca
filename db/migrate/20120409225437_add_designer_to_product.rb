class AddDesignerToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :designer_id, :integer
  end

  def self.down
    remove_column :products, :designer_id
  end
end
