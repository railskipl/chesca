class CreateHomePages < ActiveRecord::Migration
  def self.up
    create_table :home_pages do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.string :type
      t.string :effect_slideshow
      t.string :url
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :home_pages
  end
end
