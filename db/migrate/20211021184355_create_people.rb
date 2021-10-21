class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :location
      t.text :job_description
      t.string :mission_duration_sought
      t.string :experience
      t.integer :nb_of_previous_mission
      t.decimal :rating
      t.boolean :remote
      t.integer :daily_rate
      t.string :currency
      t.references :origin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
