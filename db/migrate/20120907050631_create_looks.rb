class CreateLooks < ActiveRecord::Migration
  def self.up
    create_table :looks do |t|
      t.string :title
      t.text   :content
      t.timestamps
    end
  end

  def self.down
    drop_table :looks
  end
end
