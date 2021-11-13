class AddAmountToDonations < ActiveRecord::Migration[6.0]
  def change
    add_monetize :donations, :amount, currency: { present: false }
  end
end
