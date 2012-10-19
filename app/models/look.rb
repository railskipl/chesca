class Look < ActiveRecord::Base
  has_attached_file :image, :styles => {:editor =>'325x442', :looks =>'375x285', :tiny => '100x100' },
  :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "public/system/product_images/:id/:style/:basename.:extension"
  #validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  def created_on
    created_at.strftime '%A, %B %d, %Y'
  end
end
