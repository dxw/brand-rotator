require_relative "../../brand_rotator"
require_relative "./client"

module BrandRotator::Gravatar
  class Action
    attr_reader :client

    def initialize
      @client = Client.new
    end

    def run
      image_id = upload_image
      use_image(image_id)
    end

    private

    def use_image(image_id)
      addresses = client.addresses

      client.use_image!(image_id, addresses)
    end

    def upload_image
      image_id = client.upload_image!(image)
      image_id
    end

    def image
      BrandRotator::Theme.today.fetch(:marque)
    end
  end
end
