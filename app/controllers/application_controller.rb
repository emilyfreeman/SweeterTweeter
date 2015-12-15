class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :user_profile

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # def user_profile
  #   profile_image_uri_https
  # end
end
