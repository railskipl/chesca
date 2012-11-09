class Page < ActiveRecord::Base
  has_attached_file :image, :styles => {:square => '60x60#', :tiny => '89x125>',  :large => '790x150#' },
  :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "public/system/product_images/:id/:style/:basename.:extension"

  has_and_belongs_to_many :products
  #validates_presence_of :name
  #validates_uniqueness_of :name, :allow_nil=>true,:allow_blank=>true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
