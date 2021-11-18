class AddInsertedInAnalysisToTechnologies < ActiveRecord::Migration[6.0]
  def change
    add_column :technologies, :inserted_in_analysis, :boolean, default: true
  end
end
