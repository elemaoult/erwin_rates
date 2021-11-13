class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :email
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
