class AddAddressColumnsToParkingspot < ActiveRecord::Migration
  def change
    add_column :parkingspots, :city, :string
    add_column :parkingspots, :state, :string
    add_column :parkingspots, :country, :string
  end
end
