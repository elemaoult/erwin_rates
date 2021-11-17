class AddGenderGuessIndexToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_index :freelancers, :gender_guess
  end
end
