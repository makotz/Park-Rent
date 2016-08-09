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
      if rental.event
        rental_schedule = {
          "title" => rental.user.first_name,
          "start" => rental.starttime,
          "end"   => rental.endtime,
          "color" => "#056571",
          "url"   => event_path(rental.event)
        }
      else
        rental_schedule = {
          "title" => rental.user.first_name,
          "start" => rental.starttime,
          "end"   => rental.endtime,
          "color" => "#056571"
        }
      end
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
          nono
        elsif params[:origin] == "endtime"
          params[:starttime] = DateTime.strptime(params[:starttime], "%m/%d/%Y %I:%M %P")
          params[:endtime] = params[:endtime].to_datetime
          nono
        elsif params[:origin] == "search"
          if params[:endtime] == "" || params[:starttime] == ""
            @parkingspots = Parkingspot.all
          else
            params[:endtime] = DateTime.strptime(params[:endtime], "%m/%d/%Y %I:%M %P")
            params[:starttime] = DateTime.strptime(params[:starttime], "%m/%d/%Y %I:%M %P")
            nono
          end
        end

      if params[:location] != ""
        address_search_bar(params[:location])
        @parkingspots = @parkingspots.near(@search_location, 1, units: :km)
      end

      make_markers(@parkingspots)

    else

      @parkingspots = Parkingspot.all
      make_markers(@parkingspots)

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
    params.require(:parkingspot).permit(:title, :description, :address, :city, :state, :country, :default_price, :notification)
  end

  def find_parkingspot
    @parkingspot = Parkingspot.find params[:id]
  end

  def nono
    unavailable_spots =  Rental.where(:starttime => params[:starttime]..params[:endtime])
    unavailable_spots += Rental.where(:endtime   => params[:starttime]..params[:endtime])
    nono = unavailable_spots.map { |spot| spot.parkingspot.id }.uniq
    @parkingspots = Parkingspot.where.not(id: nono)
  end

end
