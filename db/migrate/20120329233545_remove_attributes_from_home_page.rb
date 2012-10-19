class RemoveAttributesFromHomePage < ActiveRecord::Migration
  def self.up
    remove_column :home_pages, :image_file_name
    remove_column :home_pages, :image_content_type
    remove_column :home_pages, :image_file_size
    remove_column :home_pages, :image_updated_at
    remove_column :home_pages, :type
    remove_column :home_pages, :effect_slideshow
    remove_column :home_pages, :url
  end

  def self.down
    add_column :home_pages, :image_file_name
    add_column :home_pages, :image_content_type
    add_column :home_pages, :image_file_size
    add_column :home_pages, :image_updated_at
    add_column :home_pages, :type
    add_column :home_pages, :effect_slideshow
    add_column :home_pages, :url
  end
end
