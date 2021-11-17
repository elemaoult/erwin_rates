class DropIndustries < ActiveRecord::Migration[6.0]
  def change
    drop_table :industries
  end
end
