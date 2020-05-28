require "twitter"
require_relative "../twitter"

module BrandRotator::Twitter
  class Client
    attr_reader :twitter_client

    def initialize
      @twitter_client = Twitter::REST::Client.new { |config|
        config.consumer_key = ENV.fetch("TWITTER_CONSUMER_KEY")
        config.consumer_secret = ENV.fetch("TWITTER_CONSUMER_SECRET")
        config.access_token = ENV.fetch("TWITTER_ACCESS_TOKEN")
        config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
      }
    end
  end
end
