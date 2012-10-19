class NewsFeed < ActiveRecord::Base
  named_scope :active, :conditions=>['active = ? ', true]
  #validates_presence_of :media
  has_attached_file :media,
    :styles => {
      :normal=> "250x55>"}
  #validates_attachment_content_type :media, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
