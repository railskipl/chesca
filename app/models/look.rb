class Look < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  acts_as_tree :order => 'name'
  has_many :products, :through => :product_look
  has_many :product_look
  def self.top
    find(:all, :conditions => [ 'parent_id IS NULL' ])
  end
  def self.parent_look
    objects = self.all
    objects_parent =[]
    objects.each do |l|

      if l.parent.nil?
        objects_parent << l
      end
    end
    return objects_parent
  end
end
