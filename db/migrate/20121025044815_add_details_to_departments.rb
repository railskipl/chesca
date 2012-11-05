class AddDetailsToDepartments < ActiveRecord::Migration
  def self.up
    add_column :departments, :toptext, :text
    add_column :departments, :bottomtext, :text
  end

  def self.down
    remove_column :departments, :bottomtext
    remove_column :departments, :toptext
  end
end
