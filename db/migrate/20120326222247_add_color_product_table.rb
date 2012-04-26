class AddColorProductTable < ActiveRecord::Migration
  def self.up
    create_table :colors_products do |t|
      t.references :color, :product
    end
  end

  def self.down
    drop_table :colors_products
  end
end
