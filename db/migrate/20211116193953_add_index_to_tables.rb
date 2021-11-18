class AddIndexToTables < ActiveRecord::Migration[6.0]

  def change
    add_index :freelancers, :experience
    add_index :freelancers, :daily_rate_interval
    add_index :technologies, :name
    add_index :expertises, :name
 end

end
