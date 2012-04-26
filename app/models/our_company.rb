class OurCompany < ActiveRecord::Base
  attr_accessible :name, :content, :active
  named_scope :active, :conditions => ['active = ?',true]
end
