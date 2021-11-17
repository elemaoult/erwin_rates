class AddLocationIndexToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_index :freelancers, :location
  end
end
