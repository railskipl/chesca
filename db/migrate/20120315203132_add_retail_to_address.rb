class AddRetailToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :retail, :boolean
  end

  def self.down
    remove_column :addresses, :retail
  end
end
