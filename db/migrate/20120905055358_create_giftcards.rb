class CreateGiftcards < ActiveRecord::Migration
  def self.up
    create_table :giftcards do |t|
      t.string  :name
      t.integer :value
      t.integer :usage_count, :default => 0
      t.timestamps
    end
  end
  def self.down
    drop_table :giftcards
  end
end
