class FavoritesController < ApplicationController
  def create
    binding.pry
    tweet_to_fave = Twitter::Tweet.new(id: params[:tweet_id])
    current_user.favorite_tweet(tweet_to_fave)
  end
end
