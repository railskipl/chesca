class AddColumnsToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :type_post, :string
    add_column :posts, :active, :boolean
    add_column :posts, :media_file_name, :string
    add_column :posts, :media_content_type, :string
    add_column :posts, :media_file_size, :integer
    add_column :posts, :media_updated_at, :datetime
  end

  def self.down
    remove_column :posts, :type_post
    remove_column :posts, :active
    remove_column :posts, :media_file_name
    remove_column :posts, :media_content_type
    remove_column :posts, :media_file_size
    remove_column :posts, :media_updated_at
  end
end
