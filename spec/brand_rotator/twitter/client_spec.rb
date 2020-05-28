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

  describe "#update_profile_image" do
    before do
      allow_any_instance_of(BrandRotator::Twitter::Client)
        .to receive(:twitter_client) { twitter_client }
    end

    it "updates the authenticated user's profile image" do
      expect(subject.twitter_client)
        .to receive(:update_profile_image)
        .with(instance_of(String), include_entities: false, skip_status: true)

      subject.update_profile_image(File.join("..", "spec", "fixtures", "image"))
    end
  end
end
