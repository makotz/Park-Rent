class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @event.user = current_user
    if @event.save
      flash[:notice] = "Event: #{@event.title} has been added!"
      redirect_to event_path(@event)
    else
      render :new, alert: "Something went wrong..."
    end
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    if @event.update event_params
      redirect_to event_path(@event), notice: "Event info updated."
    else
      render :edit, alert: "Sorry, update did not go through..."
    end
  end


  def show
    current_user
    @event = Event.find params[:id]
    @myparkingspots = current_user.parkingspots.near([@event.latitude, @event.longitude], 1, units: :km)
    @eventparking = @event.parkingspots_for_rent
    @markers_hash = Gmaps4rails.build_markers(@eventparking) do |spot, marker|
                  marker.lat spot.latitude
                  marker.lng spot.longitude
                  marker.infowindow spot.title
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



  def event_owner?
    current_user == @event.user
  end

  helper_method :event_owner?

  private

  WALKING_DISTANCE = 560

  def event_params
    params.require(:event).permit(:title, :description, :address, :start, :end, :city, :state, :country, :suggested_price)
  end

end
