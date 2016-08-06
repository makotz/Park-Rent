class Event < ActiveRecord::Base
  belongs_to :user
  has_many :parkingspots, dependent: :nullify
  has_many :rentals, dependent: :destroy
  has_many :parkingspots_for_rent, through: :rentals, source: :parkingspot

  validates(:title, {presence: {message: "must be present!"}, uniqueness: true})
  validates :starttime, presence: true
  validates :endtime, presence: true
  validates :address, presence: true

  # validates_datetime :endtime, :after => :starttime

  def full_street_address
  [address, city, state, country].compact.join(', ')
  end

  if :city == nil
    geocoded_by :address
   else
    geocoded_by :full_street_address
  end

  after_validation :geocode
  acts_as_geolocated

  def self.search(search)
  search_condition = "%" + search + "%"
  where(['title ILIKE ? or description ILIKE ? or address ILIKE ?', search_condition, search_condition, search_condition])
  end


end
