class AddNameInOrders < ActiveRecord::Migration
  def self.up
    add_column :orders,:buyer_name,:string
  end

  def self.down
    remove_column :orders,:buyer_name
  end
end
