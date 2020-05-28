require "base64"
require "twitter"
require_relative "../image"
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

    def update_profile_image(asset_name)
      asset_path = File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "..", # twitter
          "..", # brand_rotator
          "..", # lib
          "assets",
          "#{asset_name}.svg"
        )
      )

      image = BrandRotator::Image.open_svg_as_png(asset_path, size: "400x400")
      image_data = Base64.strict_encode64(image)

      twitter_client.update_profile_image(
        image_data,
        include_entities: false,
        skip_status: true
      )
    end
  end
end
