class DropFreelancerIndustries < ActiveRecord::Migration[6.0]
  def change
    drop_table :freelancer_industries
  end
end
