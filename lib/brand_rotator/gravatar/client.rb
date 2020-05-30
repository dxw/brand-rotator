require "xmlrpc/client"
require_relative "../../brand_rotator"

module BrandRotator::Gravatar
  class Client
    attr_reader :xmlrpc_client

    def initialize
      @xmlrpc_client = XMLRPC::Client.new(
        "secure.gravatar.com",
        "/xmlrpc?user=#{email_hash}",
        443,
        nil,
        nil,
        nil,
        nil,
        true
      )
    end

    def addresses
      response = call("grav.addresses")
      response.keys
    end

    def upload_image!(asset_name)
      image = BrandRotator::Image.open_svg_asset_as_base64_png(
        asset_name,
        width: 4096
      )

      call("grav.saveData", data: image, rating: 0)
    end

    def use_image!(image_id, addresses)
      call("grav.useUserimage", userimage: image_id, addresses: addresses)
    end

    def test
      call("grav.test", test: true)
    end

    private

    def call(name, args = {})
      xmlrpc_client.call(name, auth.merge(args))
    end

    def email_hash
      @email_hash ||= Digest::MD5.hexdigest(email)
    end

    def email
      @email ||= ENV.fetch("GRAVATAR_EMAIL").downcase.strip
    end

    def auth
      @auth ||= {password: ENV.fetch("GRAVATAR_PASSWORD")}
    end
  end
end
