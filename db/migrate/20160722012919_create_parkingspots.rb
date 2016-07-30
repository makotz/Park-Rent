class CreateParkingspots < ActiveRecord::Migration
  def change
    create_table :parkingspots do |t|
      t.string :address
      t.float :longitude
      t.float :latitude
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
