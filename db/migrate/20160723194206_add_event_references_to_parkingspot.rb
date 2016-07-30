class AddEventReferencesToParkingspot < ActiveRecord::Migration
  def change
    add_reference :parkingspots, :event, index: true, foreign_key: true
  end
end
