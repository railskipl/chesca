class AddEmailToOrderTable < ActiveRecord::Migration
  def self.up
    add_column :orders, :buyer_email, :string
  end

  def self.down
    remove_column :orders, :buyer_email
  end
end
