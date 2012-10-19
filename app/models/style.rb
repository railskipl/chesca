class Style < ActiveRecord::Base
  #validates_presence_of :name
  #validates_uniqueness_of :name
  acts_as_tree
  def to_param
    "#{id}-#{name.parameterize}"
  end
  def self.parent_boutique
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
