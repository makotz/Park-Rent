class RentalsController < ApplicationController

  def create
    rental = Rental.new
    rental.parkingspot = Parkingspot.find params[:parkingspot_id]
    rental.event = Event.find params[:event_id]
    rental.start = rental.event.start - 300
    rental.end = rental.event.end + 300
    if rental.event.suggested_price != nil
      rental.price = ((rental.end-rental.start)/3600 * event.suggested_price).round(2)
    else
      rental.price = ((rental.end-rental.start)/3600 * rental.parkingspot.default_price).round(2)
    end
    if rental.save
      redirect_to event_path(rental.event), notice: "Your parking spot is now available for rent for this event."
    else
      redirect_to event_path(rental.event), alert: "Parking for it already exists!"
    end
  end

  def nonEventRental
    rental = Rental.new rental_params
    rental.user = current_user
    rental.parkingspot = Parkingspot.find params[:parkingspot_id]
    rental.price = (rental.end-rental.start)/3600 * rental.parkingspot.default_price
    if rental.save
      redirect_to user_path(current_user), notice: "Reservation has been made"
    end
  end

  def update
    rental = Rental.find params[:id]
    rental.user = current_user
    if rental.save
      redirect_to event_path(params[:event_id]), notice: "Rental reservation has been made! Enjoy the event."
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:start, :end)
  end

end
