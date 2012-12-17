class CreateRelatedProductColors < ActiveRecord::Migration
  def self.up
    create_table 'related_product_colors', :id => false do |t|
      t.integer :product_id
      t.integer :related_color_id
    end
  end
  
  def self.down
    drop_table 'related_product_colors'
  end
end
