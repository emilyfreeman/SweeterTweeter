require 'test_helper'

class UserTest < ActiveSupport::TestCase
  attr_reader :service

  def setup
    VCR.use_cassette("twitter_service#setup") do
      stub_user
      @client = stub_user
    end
  end

  test "client follower count" do
    VCR.use_cassette("twitter_service#follower_count") do
      assert_equal 40, @client.follower_count
    end
  end

  test "client profile photo" do
    VCR.use_cassette("twitter_service#profile_photo") do
      assert_equal "https://pbs.twimg.com/profile_images/1148945722/EmilyFloridaHospitalPhotoCropped.jpg", @client.profile_photo.to_s
    end
  end

  test "client favorites count" do
    VCR.use_cassette("twitter_service#favorites_count") do
      assert_equal 3, @client.favorites_count
    end
  end

  test "client following count" do
    VCR.use_cassette("twitter_service#following_count") do
      assert_equal 40, @client.following_count
    end
  end

  test "client tweet count" do
    VCR.use_cassette("twitter_service#tweet_count") do
      assert_equal 17, @client.tweet_count
    end
  end

  test "client name" do
    VCR.use_cassette("twitter_service#name") do
      assert_equal "Emily Freeman", @client.name
    end
  end

  test "client handle" do
    VCR.use_cassette("twitter_service#handle") do
      assert_equal "emily_freeman", @client.handle
    end
  end

  test "client bio" do
    VCR.use_cassette("twitter_service#bio") do
      assert_equal "I'm an entrepreneur, political junkie and blogger. The Beer Man's Guide is a quick, easy to understand guide to politics, foreign policy and current affairs.", @client.bio
    end
  end

  test "client timeline" do
    VCR.use_cassette("twitter_service#timeline") do
      assert_equal "Macedonia might finally be ready to change its name. Here a few suggestions. https://t.co/nj9CC4LnRA", @client.timeline.first.text
    end
  end

  test "client tweet" do
    VCR.use_cassette("twitter_service#tweet") do
      assert_equal "So awesome!", @client.tweet("So awesome!").text
    end
  end

  test "client favorite tweet" do
    id = 676961416688087040
    VCR.use_cassette("twitter_service#favorite_a_tweet") do
      favorited_tweet = @client.favorite(id)
    end
    VCR.use_cassette("twitter_service#find_favorited_tweet") do
      assert_equal id, @client.favorites.last.id
    end
  end
end
