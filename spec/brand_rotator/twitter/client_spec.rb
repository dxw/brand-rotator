require "brand_rotator/twitter/client"
require "twitter"

describe BrandRotator::Twitter::Client do
  let(:twitter_client) { double(Twitter::REST::Client) }

  describe ".new" do
    it "creates a Twitter client instance" do
      client = BrandRotator::Twitter::Client.new

      expect(client.twitter_client).to be_instance_of(Twitter::REST::Client)
    end
  end
end
