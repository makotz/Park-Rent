class RentalsController < ApplicationController

  def createcharge
    rental = Rental.find params[:rental_id]
    event  = Event.find params[:event_id]
    rental.user = current_user
    @amount = ((rental.price).round(2)*100).to_i

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "Invoice for #{rental.parkingspot.user.first_name} from #{rental.user.first_name} for Rental ID: #{rental.id}",
      :currency    => 'CAD'
    )

    if rental.save
      redirect_to event_path(event), notice: "Rental reservation has been made! Enjoy the event."
    else
      redirect_to event_path(event), alert: "Something went wrong with the reservation..."
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to root_path

  end


  def create
    rental = Rental.new
    rental.parkingspot = Parkingspot.find params[:parkingspot_id]
    event = Event.find params[:event_id]
    rental.event = event
    rental.starttime = rental.event.starttime - 300
    rental.endtime = rental.event.endtime + 300
    if rental.event.suggested_price != nil
      rental.price = ((rental.endtime-rental.starttime)/3600 * event.suggested_price).round(2)
    else
      rental.price = ((rental.endtime-rental.starttime)/3600 * rental.parkingspot.default_price).round(2)
    end
    if rental.save
      redirect_to event_path(event), notice: "Your parking spot is now available for rent for this event."
    else
      redirect_to event_path(event), alert: "Parking for it already exists!"
    end
  end

  def nonEventRental
    @rental = Rental.new rental_params
    @rental.user = current_user
    parkingspot = Parkingspot.find params[:parkingspot_id]
    @rental.parkingspot = parkingspot
    @rental.price = (@rental.endtime-@rental.starttime)/3600 * @rental.parkingspot.default_price
    if @rental.save
      redirect_to parkingspot_rental_charges_new_path(parkingspot, @rental)
    else
      redirect_to parkingspot_path(parkingspot), alert: "Can't make reservation"
    end
  end

  def noneventnewcharge
    rental = Rental.find params[:rental_id]
    @amount = (rental.price).round(2)
  end

  def noneventcreatecharge
    rental = Rental.find params[:rental_id]
    rental.user = current_user
    @amount = ((rental.price).round(2)*100).to_i

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "Invoice for #{rental.parkingspot.user.full_name} from #{rental.user.full_name} for Rental ID: #{rental.id}",
      :currency    => 'CAD'
    )

    if rental.save
      redirect_to parkingspot_path(rental.parkingspot), notice: "Rental reservation has been made! Enjoy the event."
    else
      redirect_to parkingspot_path(rental.parkingspot), alert: "Something went wrong with the reservation..."
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to root_path

  end

  def update
    rental = Rental.find params[:rental_id]
    rental.user = current_user
    if rental.save
      redirect_to event_path(params[:event_id]), notice: "Rental reservation has been made! Enjoy the event."
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:starttime, :endtime, :plateNumber)
  end

end
