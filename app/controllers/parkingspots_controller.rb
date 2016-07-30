class ParkingspotsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]


  def new
    @parkingspot = Parkingspot.new
  end

  def create
    @parkingspot = Parkingspot.new parkingspot_params
    @parkingspot.user = current_user
    if @parkingspot.save
      flash[:notice] = "Place added!"
      redirect_to root_path
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

  private

  def parkingspot_params
    params.require(:parkingspot).permit(:title, :description, :address, :city, :state, :country)
  end

  # def available_parkingspots
  #   params[:starttime] params[:endtime]
  # end
end