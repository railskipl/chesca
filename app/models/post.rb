class Post < ActiveRecord::Base
  # named_scope :editors, :conditions => {:type_post => 'Editors Newsletter'}
  # named_scope :trends, :conditions => {:type_post => 'Chesca Trends'}
  named_scope :looks, :conditions => {:type_post => 'Archived Looks'}
  # named_scope :editors_active, :conditions => {:type_post => 'Editors Newsletter', :active => true }
  # named_scope :trends_active, :conditions => {:type_post => 'Chesca Trends', :active => true}
  named_scope :looks_active, :conditions => {:type_post => 'Archived Looks', :active => true}


  has_attached_file :media, :styles => {:editor =>'325x442', :looks =>'375x285', :tiny => '100x100', :pinklook => '223x332' },
  :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "public/system/product_images/:id/:style/:basename.:extension"
  #validates_attachment_content_type :media, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  def created_on
    created_at.strftime '%A, %B %d, %Y'
  end
end
