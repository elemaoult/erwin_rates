class CreateOrigins < ActiveRecord::Migration[6.0]
  def change
    create_table :origins do |t|
      t.timestamp :date
      t.string :data_origin

      t.timestamps
    end
  end
end
