class StatusController < ApplicationController
  def new
    @tweet = Twitter::Tweet.new
  end

  def create
    tweet = params[:tweet]
    current_user.tweet(tweet)
    redirect_to profile_path
  end
end
