class FavoritesController < ApplicationController
  def create
    twitter_service.favorite(params[:tweet_id])
    redirect_to profile_path
  end

  def destroy
    twitter_service.unfavorite(params[:tweet_id])
    redirect_to profile_path
  end

  private

    def twitter_service
      TwitterService.new(current_user).client
    end
end
