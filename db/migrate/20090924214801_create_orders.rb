class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.references :cart
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :paypal_transaction_id
      t.string :paypal_payment_status
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
