class ParkmeMailer < ApplicationMailer

  def notify_parkingspot_owner(event, parkingspot)
    @parkingspot = parkingspot
    @event       = event
    @owner       = parkingspot.user
    mail(to: @owner.email, subject: "New Event by Your Parkingspot!")
  end

  def notify_rental_to_owner(rental)
    @rental      = rental
    mail(to: @owner.email, subject: "Your spot has been reserved!")
  end

  def rental_confirmation(event, parkingspot)
    @parkingspot = parkingspot
    @event       = event
    @owner       = parkingspot.user
    mail(to: @owner.email, subject: "New Event by Your Parkingspot!")
  end

end
