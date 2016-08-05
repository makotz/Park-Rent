class HomeController < ApplicationController

  def main
    @user = User.new
    if params[:origin]
      if params[:origin] == "starttime"
        params[:endtime] = DateTime.strptime(params[:endtime], "%m/%d/%Y %I:%M %P")
        params[:starttime] = params[:starttime].to_datetime
      elsif params[:origin] == "endtime"
        params[:starttime] = DateTime.strptime(params[:starttime], "%m/%d/%Y %I:%M %P")
        params[:endtime] = params[:endtime].to_datetime
      end
      unavailable_spots =  Rental.where(:starttime => params[:starttime]..params[:endtime])
      unavailable_spots += Rental.where(:endtime   => params[:starttime]..params[:endtime])
      nono = unavailable_spots.map { |spot| spot.parkingspot.id }.uniq
      @parkingspots = Parkingspot.where.not(id: nono)
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

end
