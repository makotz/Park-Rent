class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # methods defined here will be available to all controllers
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method

  def sign_in(user)
    session[:user_id] = user.id
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless user_signed_in?
  end

  def find_rentals(e, p)
    r = Rental.where(event_id: e, parkingspot_id: p).limit(1)
    r[0]
  end

  def parkingspot_owner?(parkingspot)
    current_user == parkingspot.user
  end

  def event_owner?
    current_user == @event.user
  end

  def address_search_bar(params)
    array = Geocoder.search(params)
    lat = array[0].data["geometry"]["location"]["lat"]
    lng = array[0].data["geometry"]["location"]["lng"]
    @search_location = [lat, lng]
    return @search_location
  end

  def make_markers(parkingspots)
    @markers_hash = Gmaps4rails.build_markers(parkingspots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow "<a href='/parkingspots/#{spot.id}'>#{spot.title}</a>"
      marker.picture({
                   url: "https://s10.postimg.org/5qml818zt/Logo_Makr_3.png",
                   "width": 75,
                   "height": 100
                  })
    end
  end

  helper_method :user_signed_in?, :current_user, :find_rentals, :parkingspot_owner?, :event_owner?, :gmaps4rails_marker_picture
end
