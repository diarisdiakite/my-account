class ReservationsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user
  before_action :set_car, only: %i[index new create]
  before_action :set_reservation, only: %i[show edit update destroy]
  # load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # GET /reservations or /reservations.json
  def index
    @user = User.find(params[:user_id])
    @cars = @user.cars
    @car = @cars.find(params[:car_id]) if params[:car_id].present?
    @reservations = @car.present? ? @car.reservations : Reservation.where(car: @cars)
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @cars = @user.cars
    @car = @cars.find(params[:car_id]) if params[:car_id].present?

    authorize! :show, @reservation

    # You may want to adjust the logic here based on your requirements
    if @car.present?
      @reservations = @car.reservations
    else
      @reservations = @reservation.cars.map(&:reservations)
    end
  end

  # GET /reservations/new
  def new
    @user = User.find(params[:user_id])
    @car = @user.cars.find(params[:car_id])
    @cars = Car.all
    @reservation = @car.reservations.build(user: @user)
  end

  # GET /reservations/1/edit
  def edit
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @cars = @user.cars
    @car = @cars.find(params[:car_id]) if params[:car_id].present?
  end

  # POST /reservations or /reservations.json
  def create
    @user = User.find(params[:user_id])
    @car = @user.cars.find(params[:car_id])
    @reservation = @car.reservations.new(reservation_params)

    # Explicitly set user_id
    @reservation.user_id = @user.id

    @reservation.car_ids = Array(params[:reservation][:car_ids]).reject(&:empty?)

    respond_to do |format|
      if @reservation.save
        format.html do
          redirect_to user_car_path(@user, @car), notice: 'Reservation was successfully created.'
        end
        format.json { render :show, status: :created, location: @reservation }
      else
        @cars = @user.cars.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    @user = User.find(params[:user_id])
    @car = @user.cars.find(params[:car_id])
    # @reservation = Reservation.find(params[:id])
    @reservation = @car.reservations.find(params[:id])

    car_ids = Array(params[:reservation][:car_ids]).reject(&:empty?)
    @reservation.car_ids = car_ids

    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to user_car_reservation_url(@user, @car, @reservation), notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to user_car_reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_user_and_cars
    @user = User.find(params[:user_id])
    @cars = @user.cars
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_car
    @user = User.find(params[:user_id])
    @cars = @user.cars
    @car = @cars.find(params[:car_id]) if params[:car_id].present?
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:user_id, :name, :amount, car_ids: [])
  end
end
  