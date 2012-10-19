class AddWashingInstructionsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :washing_instructions, :string
  end

  def self.down
    remove_column :products, :washing_instructions
  end
end
