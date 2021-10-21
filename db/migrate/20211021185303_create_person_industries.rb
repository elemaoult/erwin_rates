class CreatePersonIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :person_industries do |t|
      t.references :industry, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
