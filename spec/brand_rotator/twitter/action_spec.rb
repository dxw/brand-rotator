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

  describe "#run" do
    let(:epoch) { DateTime.new(1970, 1, 1) }

    it "updates the profile image" do
      allow(DateTime).to receive(:now) { epoch + Rational(1, 2) }

      expect(subject.client)
        .to receive(:update_profile_image)
        .with(BrandRotator::Twitter::PROFILE_IMAGES.first)

      subject.run
    end

    it "uses the number of days since epoch to determine which image to use for the new profile image" do
      days_since_epoch = 24

      allow(DateTime).to receive(:now) {
        epoch.next_day(days_since_epoch) + Rational(1, 2)
      }

      expected_index = days_since_epoch % BrandRotator::Twitter::PROFILE_IMAGES.count

      expect(subject.client)
        .to receive(:update_profile_image)
        .with(BrandRotator::Twitter::PROFILE_IMAGES[expected_index])

      subject.run
    end
  end
end
