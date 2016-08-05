class RemoveNotificationColumnFromParkingspots < ActiveRecord::Migration
  def change
    remove_column :parkingspots, :notification
    add_column :parkingspots, :notification, :boolean, :default => false
  end
end
