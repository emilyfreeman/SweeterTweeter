Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["twitter_consumer_api_key"], ENV["twitter_consumer_api_secret"]
end
