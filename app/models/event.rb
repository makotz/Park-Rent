class Event < ActiveRecord::Base
  belongs_to :user
  has_many :parkingspots, dependent: :nullify

  has_many :rentals, dependent: :destroy
  has_many :parkingspots_for_rent, through: :rentals, source: :parkingspot

  validates :title, presence: true, uniqueness: true
  validates :start, presence: true
  validates :end, presence: true

  def full_street_address
  [address, city, state, country].compact.join(', ')
  end


  # if city.exists?
  #   geocoded_by :full_street_address
  # else
    geocoded_by :address
  # end

  after_validation :geocode


  def available_parkingspots
    rentals = self.rentals.where(user_id: nil)
    @parkingspots = []
    rentals.each do |rental|
      @parkingspots << rental.parkingspot
    end
    @parkingspots
  end

end
