class AddMeasurementsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :measurement, :string
  end

  def self.down
     remove_column :products, :measurement
  end
end
