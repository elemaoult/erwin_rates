class CreatePersonExpertises < ActiveRecord::Migration[6.0]
  def change
    create_table :person_expertises do |t|
      t.references :expertise, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
