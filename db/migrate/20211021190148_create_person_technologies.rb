class CreatePersonTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :person_technologies do |t|
      t.references :technology, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
