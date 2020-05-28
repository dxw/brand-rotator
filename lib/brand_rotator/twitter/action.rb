require_relative "../twitter"
require_relative "./client"

module BrandRotator::Twitter
  class Action
    attr_reader :client

    def initialize
      @client = Client.new
    end
  end
end
