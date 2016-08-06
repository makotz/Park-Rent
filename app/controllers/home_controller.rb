class HomeController < ApplicationController

  def main
    @user         = User.new
    @event        = Event.new
    @events       = Event.all
    @parkingspot  = Parkingspot.new
    @parkingspots = Parkingspot.all
  end

end
