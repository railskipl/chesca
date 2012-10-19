class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
    create_table :pages_products, :id => false do |t|
      t.integer :product_id
      t.integer :page_id
    end
  end

  def self.down
    drop_table :pages
    drop_table :pages_products
  end
end
