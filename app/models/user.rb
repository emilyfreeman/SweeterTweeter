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

  def twitter_service
    TwitterService.new( self.oauth_token, self.oauth_token_secret )
  end

  def favorite_tweet(tweet)
    twitter_service.client.favorite(tweet)
  end

  def profile_photo
    twitter_service.client.user.profile_image_uri_https(:original)
  end

  def follower_count
    twitter_service.client.user.followers_count
  end

  def favorites_count
    twitter_service.client.user.favourites_count
  end

  def following_count
    twitter_service.client.user.friends_count
  end

  def tweet_count
    twitter_service.client.user.statuses_count
  end

  def name
    twitter_service.client.user.name
  end

  def handle
    twitter_service.client.user.screen_name
  end

  def bio
    twitter_service.client.user.description
  end

  def timeline
    twitter_service.client.home_timeline
  end

  def favorite(tweet)
    twitter_service.client.favorite(tweet)
  end

  def tweet(tweet)
    twitter_service.client.update(tweet)
  end
end
