class Address < ActiveRecord::Base
  #validates_presence_of :name
  #validates_uniqueness_of :name
  default_scope :order => 'retail DESC'
  belongs_to :location
 has_attached_file :image, :styles => {:square => '60x60#', :tiny => '89x125>',  :large => '790x150#' },
  :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "public/system/product_images/:id/:style/:basename.:extension"
 # validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
