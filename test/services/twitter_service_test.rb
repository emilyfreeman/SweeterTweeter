class TwitterServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    @service = TwitterService.new(ENV["test_oauth_token"], ENV["test_oauth_token_secret"])
    byebug
  end

  test "client" do
    VCR.use_cassette("twitter_service#client") do
      client = service.client

      assert_equal "", client.user.profile_image_uri_https
    end
  end
end
