class AddEventReferencesToRentals < ActiveRecord::Migration
  def change
    add_reference :rentals, :event, index: true, foreign_key: true
  end
end
