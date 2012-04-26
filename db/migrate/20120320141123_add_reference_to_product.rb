class AddReferenceToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :look_id, :integer
  end
  def self.down
    remove_column :products, :look_id,:integer
  end
end
