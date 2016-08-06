class ParkingspotsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_parkingspot, only: [:show, :edit, :update, :destroy]


  def new
    @parkingspot = Parkingspot.new
  end

  def create
    @parkingspot = Parkingspot.new parkingspot_params
    @parkingspot.user = current_user
    if @parkingspot.save
      redirect_to parkingspot_path(@parkingspot), notice: "Parkingspot: #{@parkingspot.title} added!"
    else
      render :new
    end
  end

  def calendar
    parkingspot = Parkingspot.find params[:parkingspot_id]
    schedule = []
    parkingspot.rentals.each do |rental|
      rental_schedule = {
        "title" => "Hello",
        "start" => rental.starttime,
        "end"   => rental.endtime,
        "color" => "blue"
        # "url"   => event_path(rental.event)
      }
      schedule << rental_schedule
    end
    render json: schedule
  end

  def show
    @event = Event.new
    @rental = Rental.new
  end

  def edit
  end

  def update
    if @parkingspot.update parkingspot_params
      redirect_to parkingspot_path(@parkingspot), notice: "Event info updated."
    else
      render :edit, alert: "Sorry, update did not go through..."
    end
  end

  def index
    if params[:origin]
        if params[:origin] == "starttime"
          params[:endtime] = DateTime.strptime(params[:endtime], "%m/%d/%Y %I:%M %P")
          params[:starttime] = params[:starttime].to_datetime
        elsif params[:origin] == "endtime"
          params[:starttime] = DateTime.strptime(params[:starttime], "%m/%d/%Y %I:%M %P")
          params[:endtime] = params[:endtime].to_datetime
        elsif params[:origin] == "search"
          params[:endtime] = DateTime.strptime(params[:endtime], "%m/%d/%Y %I:%M %P")
          params[:starttime] = DateTime.strptime(params[:starttime], "%m/%d/%Y %I:%M %P")
          address_search_bar(params[:location])
        end
      unavailable_spots =  Rental.where(:starttime => params[:starttime]..params[:endtime])
      unavailable_spots += Rental.where(:endtime   => params[:starttime]..params[:endtime])
      nono = unavailable_spots.map { |spot| spot.parkingspot.id }.uniq
      @parkingspots = Parkingspot.where.not(id: nono)
      if params[:origin] == "search"
        @parkingspots = @parkingspots.near(@search_location, 2, units: :km)
      end
      @markers_hash = Gmaps4rails.build_markers(@parkingspots) do |spot, marker|
                    marker.lat spot.latitude
                    marker.lng spot.longitude
                    marker.infowindow spot.title
                  end
    else
      @parkingspots = Parkingspot.all
      @markers_hash = Gmaps4rails.build_markers(@parkingspots) do |spot, marker|
        marker.lat spot.latitude
        marker.lng spot.longitude
        marker.infowindow spot.title
      end
    end

    respond_to do |format|
      format.json {render json: {parkingspots: @parkingspots, markers_hash: @markers_hash}}
      format.html
    end

  end

  def destroy
    @parkingspot.destroy
    redirect_to root_path, notice: "Destroyed parkingspot"
  end

  private

  def parkingspot_params
    params.require(:parkingspot).permit(:title, :description, :address, :city, :state, :country, :default_price)
  end

  def find_parkingspot
    @parkingspot = Parkingspot.find params[:id]
  end

end
