class AddIndexOnIncludedInAnalysisToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_index :freelancers, :included_in_analysis
  end
end
