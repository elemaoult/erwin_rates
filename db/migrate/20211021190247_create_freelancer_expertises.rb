class CreateFreelancerExpertises < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancer_expertises do |t|
      t.references :expertise, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
