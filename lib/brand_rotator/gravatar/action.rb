require_relative "../../brand_rotator"
require_relative "./client"

module BrandRotator::Gravatar
  class Action
    attr_reader :client

    def initialize
      @client = Client.new
    end

    def run
      puts client.test
    end
  end
end
