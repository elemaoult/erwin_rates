class CreateFreelancerIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancer_industries do |t|
      t.references :industry, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
