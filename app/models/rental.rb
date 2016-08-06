class Rental < ActiveRecord::Base
  belongs_to :parkingspot
  belongs_to :event
  belongs_to :user
  # TO-DO: add validation so that parkingspot owner cannnot be renter
  # validates :event_id, uniqueness: {scope: :user_id}, unless: Proc.new { |a| a.event_id == nil }

  validates_datetime :endtime, :after => :starttime
  validates :starttime, :endtime, :overlap => {:scope => "parkingspot_id"}

end
