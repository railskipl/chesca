class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.string :name
      t.boolean :visible

      t.timestamps
    end
  end

  def self.down
    drop_table :styles
  end
end
