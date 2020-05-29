require "twitter"
require_relative "../../brand_rotator"
require_relative "../image"

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

    def update_profile_image(asset_name)
      image = BrandRotator::Image.open_svg_asset_as_base64_png(
        asset_name,
        width: 400
      )

      twitter_client.update_profile_image(
        image,
        include_entities: false,
        skip_status: true
      )
    end
  end
end
