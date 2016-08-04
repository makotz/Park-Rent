class Event < ActiveRecord::Base
  belongs_to :user
  has_many :parkingspots, dependent: :nullify

  has_many :rentals, dependent: :destroy
  has_many :parkingspots_for_rent, through: :rentals, source: :parkingspot

  validates(:title, {presence: {message: "must be present!"}, uniqueness: true})
  validates :starttime, presence: true
  validates :endtime, presence: true
  validates :address, presence: true
  validate :date_validation

  validates_datetime :endtime, :after => :starttime # Method symbol

  def full_street_address
  [address, city, state, country].compact.join(', ')
  end

  if :city == ""
    geocoded_by :address
   else
    geocoded_by :full_street_address
  end

  after_validation :geocode

end
