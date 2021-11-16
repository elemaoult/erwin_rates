class RemoveReferenceFromDonation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :donations, :user, index: true, foreign_key: true
  end
end
