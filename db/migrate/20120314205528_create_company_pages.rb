class CreateCompanyPages < ActiveRecord::Migration
  def self.up
    create_table :company_pages do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :company_pages
  end
end
