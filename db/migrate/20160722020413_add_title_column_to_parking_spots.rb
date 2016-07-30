class AddTitleColumnToParkingSpots < ActiveRecord::Migration
  def change
    add_column :parkingspots, :title, :string
  end
end
