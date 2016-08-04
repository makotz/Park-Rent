class Rental < ActiveRecord::Base
  belongs_to :parkingspot
  belongs_to :event
  belongs_to :user

  validates :event_id, uniqueness: {scope: :parkingspot_id}
  # validates :event_id, uniqueness: {scope: :user_id}
  # TO-DO: add validation so that parkingspot owner cannnot be renter
  validates_datetime :endtime, :after => :starttime # Method symbol

  validates :starttime, :endtime, :overlap => {:scope => "parkingspot_id"}
end
