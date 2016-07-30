class RemoveEventIdColumnFromParkingspot < ActiveRecord::Migration
  def change
    remove_column :parkingspots, :event_id
  end
end
