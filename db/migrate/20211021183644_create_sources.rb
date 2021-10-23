class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.timestamp :date
      t.string :data_source
      t.boolean :seed_valid

      t.timestamps
    end
  end
end
