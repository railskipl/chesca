class Color < ActiveRecord::Base
  has_many :product_sizes
  has_many :product, :through => :product_sizes
  has_attached_file :image,:styles => { :square => "21x21#" },
     :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
     :path => "public/system/color/:id/:style/:basename.:extension"
  #validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
end
