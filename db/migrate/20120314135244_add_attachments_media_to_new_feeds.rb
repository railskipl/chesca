class AddAttachmentsMediaToNewFeeds < ActiveRecord::Migration
  def self.up
    add_column :news_feeds, :media_file_name, :string
    add_column :news_feeds, :media_content_type, :string
    add_column :news_feeds, :media_file_size, :integer
    add_column :news_feeds, :media_updated_at, :datetime
  end
  def self.down
    remove_column :news_feeds, :media_file_name, :string
    remove_column :news_feeds, :media_content_type, :string
    remove_column :news_feeds, :media_file_size, :integer
    remove_column :news_feeds, :media_updated_at, :datetime
  end
end
