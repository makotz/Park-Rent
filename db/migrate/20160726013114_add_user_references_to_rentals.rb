class AddUserReferencesToRentals < ActiveRecord::Migration
  def change
    remove_column :rentals, :renter_id
    add_reference :rentals, :user, index: true, foreign_key: true
  end
end
