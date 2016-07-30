class RemoveRenterColumnInRentals < ActiveRecord::Migration
  def change
    remove_column :rentals, :renter
  end
end
