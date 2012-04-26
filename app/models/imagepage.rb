class Imagepage < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumbnail => '60x60>'}
end
