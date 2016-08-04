class RemoveEndColumnInEvents < ActiveRecord::Migration
  def change
    remove_column :rentals, :end
    remove_column :rentals, :start
    add_column :rentals, :starttime, :datetime
    add_column :rentals, :endtime, :datetime
    remove_column :events, :end
    remove_column :events, :start
    add_column :events, :starttime, :datetime
    add_column :events, :endtime, :datetime
  end
end
