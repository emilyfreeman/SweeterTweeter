class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      # session[:twitter_access_token] = user.oauth_token
      # session[:twitter_access_token_secret] = user.oauth_token_secret
    end
    redirect_to root_path
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
