require "brand_rotator/twitter/action"
require "twitter"

describe BrandRotator::Twitter::Action do
  let(:twitter_client) { double(Twitter::REST::Client) }

  before do
    allow_any_instance_of(BrandRotator::Twitter::Client)
      .to receive(:twitter_client) { twitter_client }
  end

  describe ".new" do
    it "creates a client instance" do
      action = BrandRotator::Twitter::Action.new

      expect(action.client).to be_instance_of(BrandRotator::Twitter::Client)
    end
  end
end
