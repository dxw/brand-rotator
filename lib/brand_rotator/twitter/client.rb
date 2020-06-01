require "tempfile"
require "twitter"
require_relative "../../brand_rotator"
require_relative "../image"
require_relative "../theme"

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

    def update_profile_image!(asset_name)
      image = BrandRotator::Image.open_svg_asset_as_png(
        asset_name,
        width: 400
      )

      file = Tempfile.new("twitter_profile.png")

      begin
        file.write(image)
        file.rewind

        twitter_client.update_profile_image(
          file,
          include_entities: false,
          skip_status: true
        )
      ensure
        file.close
        file.unlink
      end
    end
  end
end
