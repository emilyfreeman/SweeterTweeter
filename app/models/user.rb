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
    @twitter_service ||= TwitterService.new(self).client
  end

  def twitter_user
    @twitter_user ||= twitter_service.user
  end

  def profile_photo
    twitter_user.profile_image_uri_https(:original)
  end

  def follower_count
    twitter_user.followers_count
  end

  def favorites_count
    twitter_user.favourites_count
  end

  def following_count
    twitter_user.friends_count
  end

  def tweet_count
    twitter_user.statuses_count
  end

  def name
    twitter_user.name
  end

  def handle
    twitter_user.screen_name
  end

  def bio
    twitter_user.description
  end

  def timeline
    twitter_service.home_timeline
  end

  def favorite(tweet)
    twitter_service.favorite(tweet)
  end

  def tweet(tweet)
    twitter_service.update(tweet)
  end

  def favorites
    twitter_service.favorites
  end
end
