class AddNotifyColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :notify, :boolean, default: false
  end
end
