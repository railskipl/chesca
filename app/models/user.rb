class User < ActiveRecord::Base
  attr_accessible :name, :email
  validates_presence_of :email, :message => "Please enter Email."
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
end
