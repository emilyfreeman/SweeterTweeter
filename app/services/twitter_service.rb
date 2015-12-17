class TwitterService

  def initialize(user)
    @oauth_token = user.oauth_token
    @oauth_token_secret = user.oauth_token_secret
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_api_key"]
      config.consumer_secret     = ENV["twitter_consumer_api_secret"]
      config.access_token        = @oauth_token
      config.access_token_secret = @oauth_token_secret
    end
  end
end
