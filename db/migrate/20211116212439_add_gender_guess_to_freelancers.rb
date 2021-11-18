class AddGenderGuessToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_column :freelancers, :gender_guess, :string
  end
end
