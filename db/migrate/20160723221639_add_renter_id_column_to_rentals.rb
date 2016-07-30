class AddRenterIdColumnToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :renter, :Integer
  end
end
