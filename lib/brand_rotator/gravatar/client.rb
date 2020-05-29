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
