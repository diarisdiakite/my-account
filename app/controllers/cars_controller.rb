class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: %i[show edit update destroy]
  load_and_authorize_resource except: [:destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # GET /cars or /cars.json
  def index
    @user = current_user
    @cars = Car.all
  end

  # GET /cars/1 or /cars/1.json
  def show
    @user = current_user
    @cars = @user.cars
    @car = @user.cars.find(params[:id])
    @reservations = @car.reservations
    @reservation = @user.cars.flat_map(&:reservations).find(params[:id])
  end

  # GET /cars/new
  def new
    @user = current_user
    @car = current_user.cars.new
  end

  # GET /cars/1/edit
  def edit
    @user = current_user
    @car = @user.cars.find(params[:id])
  end

  # POST /cars or /cars.json
  def create
    @user = current_user
    @car = current_user.cars.new(car_params)
    authorize! :create, @car

    respond_to do |format|
      if @car.save
        format.html { redirect_to user_url(@user), notice: 'Car was successfully created.' }
        # format.html { redirect_to frontendUrls[:reactCarsIndex], notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    @user = current_user
    @car = current_user.cars.find(params[:id])

    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to user_cars_url, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @user = current_user
    @car = @user.cars.find(params[:id])

    # Update foreign key references in car_reservations table
    @car.car_reservations.destroy_all

    # Then destroy the car
    @car.destroy

    respond_to do |format|
      format.html { redirect_to user_cars_url(@user), notice: 'Car was successfully destroyed.' and return }
      format.json { head :no_content }
    end

    @car.destroy
    respond_to do |format|
      format.html { redirect_to user_cars_url(@user), notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  # Only allow a list of trusted parameters through.
  def car_params
    params.require(:car).permit(:name, :icon, :description, :facebook, :twitter, :website, :finance_fee,
                                :ption_to_purchase_fee, :total_amount_payable, :duration)
  end
end
