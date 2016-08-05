class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :search]
  before_action :find_event, only: [:edit, :show, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @event.user = current_user
    if @event.save
      send_notification_email(@event)
      redirect_to event_path(@event), notice: "Event: #{@event.title} has been created!"
    else
      render :new, alert: "Something went wrong..."
    end
  end

  def edit
  end

  def update
    if @event.update event_params
      redirect_to event_path(@event), notice: "Event info updated."
    else
      render :edit, alert: "Sorry, update did not go through..."
    end
  end


  def show
    if current_user
      @myparkingspots = current_user.parkingspots.near([@event.latitude, @event.longitude], 4000, units: :km)
    else
      @myparkingspots = []
    end
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
    @event.destroy
    # redirect_to root_path, alert: "access defined"
    render root_path, notice: "Event deleted"
  end

  def search
    @events = Event.search(params[:searchterm])
    respond_to do |format|
      format.json {render json: @events}
      format.html
    end
  end


  private

  WALKING_DISTANCE = 400

  def event_params
    params.require(:event).permit(:title, :description, :address, :starttime, :endtime, :city, :state, :country, :suggested_price, :notify)
  end

  def find_event
    @event = Event.find params[:id]
  end

  def send_notification_email(event)
    notifyparkingspots = Parkingspot.near([event.latitude, event.longitude], 400, units: :km).where(notification: true)
    if event.notify
      notifyparkingspots.each do |parkingspot|
      ParkmeMailer.notify_parkingspot_owner(event, parkingspot).deliver_now
      end
    end
  end

end
