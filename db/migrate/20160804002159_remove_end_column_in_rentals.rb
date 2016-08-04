class RemoveEndColumnInRentals < ActiveRecord::Migration
  def change
    remove_column :rentals, :end
    remove_column :rentals, :start
    add_column :rentals, :start, :datetime
    add_column :rentals, :end, :datetime
  end
end
