class AddGroupNameIndexToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_index :technologies, :group_name
    add_index :technologies, :inserted_in_analysis
  end
end
