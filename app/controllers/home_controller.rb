class HomeController < ApplicationController

  def main
    @user         = User.new
    @event        = Event.new
    @events       = Event.all
    @parkingspot  = Parkingspot.new
    @parkingspots = Parkingspot.all
    make_markers(@parkingspots)
  end

end
