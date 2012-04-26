class AddInfoToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :info, :text
  end

  def self.down
    remove_column :addresses, :info
  end
end
