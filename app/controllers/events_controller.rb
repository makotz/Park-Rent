class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @event.user = current_user
    if @event.save
      flash[:notice] = "Place added!"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    current_user
    @event = Event.find params[:id]
    @parkingspots = @event.available_parkingspots
    @markers_hash = Gmaps4rails.build_markers(@parkingspots) do |campaign, marker|
                  marker.lat campaign.latitude
                  marker.lng campaign.longitude
                  marker.infowindow campaign.title
                end
  end

  def index
    @events = Event.all
  end

  def destroy
    @event = Event.find params[:id]
    redirect_to root_path, alert: "access defined" unless can? :destroy, @event
    @event.destroy
    render root_path, notice: "Event deleted"
  end



  def find_rentals(e, p)
    r = Rental.where(event_id: e, parkingspot_id: p)
    r[0]
  end

  helper_method :find_rentals

  private

  def event_params
    params.require(:event).permit(:title, :description, :address, :start, :end, :city, :state, :country)
  end

end
