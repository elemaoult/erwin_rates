class AddRemoteIndexToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_index :freelancers, :remote
  end
end
