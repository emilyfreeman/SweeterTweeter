class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    byebug
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = auth_info.extra.raw_info.name
      new_user.screen_name        = auth_info.extra.raw_info.screen_name
      new_user.oauth_token        = auth_info.credentials.token
      new_user.oauth_token_secret = auth_info.credentials.secret
    end
  end

  def twitter
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_api_key"]
      config.consumer_secret     = ENV["twitter_consumer_api_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def profile_photo
    twitter.user.profile_image_uri_https(:original)
  end

  def name
    # twitter.user.profile_image_uri_https(:original)
  end

  def handle
    # twitter.user.profile_image_uri_https(:original)
  end

  def bio

  end
end
