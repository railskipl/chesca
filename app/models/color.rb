class Color < ActiveRecord::Base
  has_many :product_sizes
  has_many :product, :through => :product_sizes
  has_attached_file :image, :styles => {:square => '21x21#'}
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
