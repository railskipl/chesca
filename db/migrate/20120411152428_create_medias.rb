class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.string :title
      t.string :media_file_name
      t.string :media_content_type
      t.integer :media_file_size
      t.datetime :media_updated_at
      t.text :content
      t.string :type_media
      t.boolean :icon
      t.boolean :active
      t.timestamps
    end
  end
  def self.down
    drop_table :medias
  end
end
