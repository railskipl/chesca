class AddContentToHomePage < ActiveRecord::Migration
  def self.up
    add_column :home_pages, :content, :text
  end

  def self.down
    remove_column :home_pages, :content
  end
end
