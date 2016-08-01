class AddNotificationColumnToParkingspot < ActiveRecord::Migration
  def change
    add_column :parkingspots, :notification, :boolean
  end
end
