class AddPlateNumberToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :plateNumber, :string
  end
end
