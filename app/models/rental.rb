class Rental < ActiveRecord::Base
  belongs_to :parkingspot
  belongs_to :event
  belongs_to :user

  validates :event_id, uniqueness: {scope: :parkingspot_id}
  # TO-DO: add validation so that parkingspot owner cannnot be renter
end
