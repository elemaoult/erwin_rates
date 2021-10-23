class CreateFreelancerTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancer_technologies do |t|
      t.references :technology, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
