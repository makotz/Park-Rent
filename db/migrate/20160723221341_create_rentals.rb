class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.datetime :start
      t.datetime :end
      t.float :price
      t.references :parkingspot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
