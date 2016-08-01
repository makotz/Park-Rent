class AddSuggestedPriceColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :suggested_price, :float
  end
end
