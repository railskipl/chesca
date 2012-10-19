class AddAttachmentsImageToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :image_file_name, :string
    add_column :addresses, :image_content_type, :string
    add_column :addresses, :image_file_size, :integer
    add_column :addresses, :image_updated_at, :datetime
    add_column :addresses, :url, :string
  end

  def self.down
    remove_column :addresses, :image_updated_at
    remove_column :addresses, :image_file_size
    remove_column :addresses, :image_content_type
    remove_column :addresses, :image_file_name
    remove_column :addresses, :url, :string
  end
end
