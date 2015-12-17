class FavoritesController < ApplicationController
  def create
    TwitterService.new(current_user).client.favorite(params[:tweet_id])
    redirect_to profile_path
  end
end
