class CreateNewDepartments < ActiveRecord::Migration
  def self.up
    create_table :new_departments do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :new_departments
  end
end
