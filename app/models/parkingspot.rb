class Parkingspot < ActiveRecord::Base
  belongs_to :user

  has_many :rentals, dependent: :destroy
  has_many :events, through: :rentals
  #
  validates :user_id, presence: true
  validates :title, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  validates_numericality_of :default_price, :only_float => true, :greater_than_or_equal_to => 0

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

  private

  def self.search(search)
  search_condition = "%" + search + "%"
  where(['title ILIKE ? or description ILIKE ?', search_condition, search_condition])
  end

end
