class UsersController < ApplicationController
  before_action :current_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "You're now signed up!"
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if current_user.update user_params
      redirect_to root_path, notice: "Information updated!"
    else
      render :edit
    end
  end

  def managementcalendar

    schedule = []
    reservations = current_user.rentals
    parkingspots = current_user.parkingspots

    parkingspots.each do |parkingspot|
      parkingspot.rentals.each do |rental|
        if rental.user
        rentalschedule = {
          "title" => "LEASE: #{rental.parkingspot.title}",
          "start" => rental.starttime,
          "end" => rental.endtime,
          "url" => parkingspot_path(rental.parkingspot),
          "color" => "#FF6A5C" }
        schedule << rentalschedule
        end
      end
    end

    reservations.each do |rental|
      rentalschedule = {
        "title" => "RENTAL: #{rental.parkingspot.title}",
        "start" => rental.starttime,
        "end" => rental.endtime,
        "url" => parkingspot_path(rental.parkingspot),
        "color" => '#056571' }
      schedule << rentalschedule
    end

    schedule.flatten!
    render json: schedule
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
