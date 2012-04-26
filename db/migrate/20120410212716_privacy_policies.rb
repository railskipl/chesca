class PrivacyPolicies < ActiveRecord::Migration
  def self.up
    create_table :privacy_policies do |t|
      t.string :name
      t.text :content
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :privacy_policies
  end
end
