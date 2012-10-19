class AddFieldsForSeo < ActiveRecord::Migration
  def self.up
    add_column :departments, :description, :text
    add_column :departments, :keywords, :text
    add_column :styles, :description, :text
    add_column :styles, :keywords, :text
  end

  def self.down
    remove_column :departments, :description
    remove_column :departments, :keywords

    remove_column :styles, :description
    remove_column :styles, :keywords
  end
end
