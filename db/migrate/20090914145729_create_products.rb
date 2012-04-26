class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :code
      t.text :description
      t.string :composition
      t.decimal :price, :precision => 8, :scale => 2
      t.boolean :visible
      t.boolean :available
      t.references :department
      t.references :style

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
