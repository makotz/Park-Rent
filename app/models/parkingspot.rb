class Parkingspot < ActiveRecord::Base
  belongs_to :user

  has_many :rentals, dependent: :destroy
  has_many :events, through: :rentals

  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true

  def full_street_address
  [address, city, state, country].compact.join(', ')
  end

  # if city.exists?
  #   geocoded_by :full_street_address
  # else
    geocoded_by :address
  # end

  after_validation :geocode

end
