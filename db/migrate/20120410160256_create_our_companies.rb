class CreateOurCompanies < ActiveRecord::Migration
  def self.up
    create_table :our_companies do |t|
      t.string :name
      t.text :content
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :our_companies
  end
end
