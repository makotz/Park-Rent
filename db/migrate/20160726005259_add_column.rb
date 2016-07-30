class AddColumn < ActiveRecord::Migration
  def change
    add_reference :rentals, :renter, references: :users
  end
end
