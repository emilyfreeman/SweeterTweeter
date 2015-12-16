class FavoritesController < ApplicationController
  def create
    TwitterService.new(current_user.oauth_token, current_user.oauth_token_secret).client.favorite(params[:tweet_id])
    redirect_to profile_path
  end
end
