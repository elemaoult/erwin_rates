class AddIncludedInAnalysisToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_column :freelancers, :included_in_analysis, :boolean, default: true
  end
end
