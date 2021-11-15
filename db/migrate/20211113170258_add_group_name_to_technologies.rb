class AddGroupNameToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_column :technologies, :group_name, :string
  end
end
