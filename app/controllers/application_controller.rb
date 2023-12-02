class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: -> { request.controller_class == SplashController }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :bio, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:name, :bio, :email, :password, :current_password)
    end
  end

  def after_sign_in_path_for(resource)
    user_path(resource) # adjust this line based on your routes
  end
end
