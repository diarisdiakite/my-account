class UsersController < ApplicationController
  load_and_authorize_resource

  skip_before_action :authenticate_user!, only: %i[index show]

  # Create an index action
  def index
    @users = User.all
  end

  # Create a show action
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.limit(3)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
