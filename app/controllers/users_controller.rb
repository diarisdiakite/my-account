class UsersController < ApplicationController
  load_and_authorize_resource

  skip_before_action :authenticate_user!, only: %i[index show]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # Create an index action
  def index
    @users = User.all
  end

  # Create a show action
  def show
    @user = User.find(params[:id])
    @cars = @user.cars
    @categories = @user.categories
    # Other logic as needed
    p @user
    p @cars
  end

  private

  def not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
