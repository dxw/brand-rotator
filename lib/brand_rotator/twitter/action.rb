require "date"
require_relative "../../brand_rotator"
require_relative "../config"
require_relative "client"

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
      client.update_profile_image!(profile_image)
    end

    def profile_image
      BrandRotator::Theme.today.fetch(:marque)
    end
  end
end
