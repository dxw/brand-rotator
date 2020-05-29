require "date"
require_relative "../../brand_rotator"
require_relative "../config"
require_relative "./client"

module BrandRotator::Twitter
  class Action
    attr_reader :client

    def initialize
      @client = Client.new
    end

    def run
      update_profile
    end

    private

    def update_profile
      client.update_profile_image(profile_image)
    end

    def profile_image
      now = DateTime.now
      today = DateTime.new(now.year, now.month, now.day)
      seconds_since_epoch = today.to_time.to_i
      days_since_epoch = seconds_since_epoch / (60 * 60 * 24)

      image_index_for_today = days_since_epoch %
        BrandRotator::Config::THEMES.count

      BrandRotator::Config::THEMES[image_index_for_today].fetch(:marque)
    end
  end
end
