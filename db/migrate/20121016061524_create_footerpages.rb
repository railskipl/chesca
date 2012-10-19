class CreateFooterpages < ActiveRecord::Migration
  def self.up
    create_table :footerpages do |t|
      t.string :name
      t.text   :content
      t.timestamps
    end
  end

  def self.down
    drop_table :footerpages
  end
end
