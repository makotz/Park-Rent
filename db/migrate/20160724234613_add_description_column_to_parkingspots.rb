class AddDescriptionColumnToParkingspots < ActiveRecord::Migration
  def change
    add_column :parkingspots, :description, :text
  end
end
