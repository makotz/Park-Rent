class ParkingspotsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]


  def new
    @parkingspot = Parkingspot.new
  end

  def create
    @parkingspot = Parkingspot.new parkingspot_params
    @parkingspot.user = current_user
    if @parkingspot.save
      flash[:notice] = "Parkingspot: #{@parkingspot.title} added!"
      redirect_to parkingspot_path(@parkingspot)
    else
      render 'new'
    end
  end

  def calendar
    parkingspot = Parkingspot.find(params[:parkingspot_id])
    schedule = []
    parkingspot.rentals.each do |rental|
      rental_schedule = {
        "title" => rental.event.title,
        "start" => rental.start,
        "end"   => rental.end,
        "color" => "blue",
        "url"   => event_path(rental.event)
      }
      schedule << rental_schedule
    end
    render json: schedule
  end

  def show
    @parkingspot = Parkingspot.find(params[:id])
    @rental = Rental.new
  end

  def edit
    @parkingspot = Parkingspot.find params[:id]
  end

  def update
    @parkingspot = Parkingspot.find params[:id]
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
      end
      unavailable_spots =  Rental.where(:start => params[:starttime]..params[:endtime])
      unavailable_spots += Rental.where(:end   => params[:starttime]..params[:endtime])
      nono = unavailable_spots.map { |spot| spot.parkingspot.id }.uniq
      @parkingspots = Parkingspot.where.not(id: nono)
    else
      @parkingspots = Parkingspot.all
    end

    @markers_hash = Gmaps4rails.build_markers(@parkingspots) do |campaign, marker|
                  marker.lat campaign.latitude
                  marker.lng campaign.longitude
                  marker.infowindow campaign.title
                end

    respond_to do |format|
      format.json {render json: @parkingspots}
      format.html
    end

  end

  def parkingspot_owner?
    current_user == @parkingspot.user
  end

  helper_method :parkingspot_owner?

  private

  def parkingspot_params
    params.require(:parkingspot).permit(:title, :description, :address, :city, :state, :country, :default_price)
  end

  # def available_parkingspots
  #   params[:starttime] params[:endtime]
  # end
end
