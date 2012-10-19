class AddGiftcardIdToCarts < ActiveRecord::Migration
  def self.up
    add_column :carts, :giftcard_id, :integer
  end

  def self.down
    remove_column :carts, :giftcard_id
  end
end
