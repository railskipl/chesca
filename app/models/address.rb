class Address < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  default_scope :order => 'retail DESC'
  belongs_to :location
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
