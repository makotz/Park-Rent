class RentalsController < ApplicationController

  def create
    rental = Rental.new
    event = Event.find params[:event_id]
    rental.parkingspot_id = params[:parkingspot_id]
    rental.event_id = params[:event_id]
    rental.start = event.start
    rental.end = event.start
    if rental.save
      redirect_to event_path(params[:event_id])
    end
  end

  def update
    rental = Rental.find params[:id]
    rental.user = current_user
    if rental.save
      redirect_to event_path(params[:event_id]), notice: "Rental completed!"
    end
  end

end
