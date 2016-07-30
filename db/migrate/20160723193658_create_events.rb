class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start
      t.datetime :end
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps null: false
    end
  end
end
