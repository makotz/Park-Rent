class AddDefaultPriceColumnToParkingspot < ActiveRecord::Migration
  def change
    add_column :parkingspots, :default_price, :float
  end
end
