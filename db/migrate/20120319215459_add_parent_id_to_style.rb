class AddParentIdToStyle < ActiveRecord::Migration
  def self.up
    add_column :styles, :parent_id, :integer
  end

  def self.down
    remove_column :styles, :parent_id
  end
end
