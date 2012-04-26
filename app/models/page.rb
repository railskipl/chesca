class Page < ActiveRecord::Base
  has_attached_file :image, :styles => {  :large => '790x150#' },:url => "/system/pages/:id/:style/:filename"

  has_and_belongs_to_many :products
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_nil=>true,:allow_blank=>true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
