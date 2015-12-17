class FavoritesController < ApplicationController
  def create
    current_user.favorite(params[:tweet_id])
    redirect_to profile_path
  end

  def destroy
    current_user.unfavorite(params[:tweet_id])
    redirect_to profile_path
  end
end
