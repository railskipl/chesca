class RemoveAddressToAddress < ActiveRecord::Migration
  def self.up
    remove_column :addresses, :address
  end

  def self.down
    add_column :addresses, :address
  end
end
