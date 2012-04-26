class AddParentIdToDepartment < ActiveRecord::Migration
  def self.up
    add_column :departments, :parent_id, :integer
  end

  def self.down
    remove_column :departments, :parent_id
  end
end
