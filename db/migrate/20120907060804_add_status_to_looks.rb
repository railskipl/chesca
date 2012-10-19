class AddStatusToLooks < ActiveRecord::Migration
  def self.up
    add_column :looks, :active, :boolean
  end

  def self.down
    remove_column :looks, :active
  end
end
