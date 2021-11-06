class AddDailyRateIntervalToFreelancers < ActiveRecord::Migration[6.0]
  def change
    add_column :freelancers, :daily_rate_interval, :integer
  end
end
