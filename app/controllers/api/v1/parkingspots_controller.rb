class Api::V1::ParkingspotsController < ApplicationController

  def index
    @parkingspots = Parkingspot.all
    render json: @parkingspots
  end

end
