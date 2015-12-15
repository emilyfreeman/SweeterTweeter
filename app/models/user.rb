class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_api_key"]
      config.consumer_secret     = ENV["twitter_consumer_api_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def profile_photo
    twitter_client.user.profile_image_uri_https(:original)
  end

  def follower_count
    twitter_client.user.followers_count
  end

  def favorites_count
    twitter_client.user.favourites_count
  end

  def following_count
    twitter_client.user.friends_count
  end

  def tweet_count
    twitter_client.user.statuses_count
  end

  def name
    twitter_client.user.name
  end

  def handle
    twitter_client.user.screen_name
  end

  def bio
    twitter_client.user.description
  end

  def timeline
    twitter_client.home_timeline
  end
end
