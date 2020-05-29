require "brand_rotator/gravatar/action"
require "xmlrpc/client"

describe BrandRotator::Gravatar::Action do
  let(:xmlrpc_client) { double(XMLRPC::Client) }
  let(:addresses) { ["test@example.com", "another@example.com"] }
  let(:image_id) { "123456" }

  before do
    allow_any_instance_of(BrandRotator::Gravatar::Client)
      .to receive(:xmlrpc_client) { xmlrpc_client }
    allow_any_instance_of(BrandRotator::Gravatar::Client)
      .to receive(:addresses) { addresses }
    allow_any_instance_of(BrandRotator::Gravatar::Client)
      .to receive(:upload_image) { image_id }
    allow_any_instance_of(BrandRotator::Gravatar::Client).to receive(:use_image)
  end

  describe ".new" do
    it "creates a client instance" do
      action = BrandRotator::Gravatar::Action.new

      expect(action.client).to be_instance_of(BrandRotator::Gravatar::Client)
    end
  end

  describe "#run" do
    let(:epoch) { DateTime.new(1970, 1, 1) }

    it "uploads an image" do
      allow(DateTime).to receive(:now) { epoch + Rational(1, 2) }

      expect(subject.client)
        .to receive(:upload_image)
        .with(BrandRotator::Config::THEMES.first.fetch(:marque))

      subject.run
    end

    it "uses the number of days since epoch to determine which image to upload" do
      days_since_epoch = 24
      expected_index = days_since_epoch % BrandRotator::Config::THEMES.count

      allow(DateTime).to receive(:now) {
        epoch.next_day(days_since_epoch) + Rational(1, 2)
      }
      expect(subject.client)
        .to receive(:upload_image)
        .with(BrandRotator::Config::THEMES[expected_index].fetch(:marque))

      subject.run
    end

    it "associates the uploaded image with all email addresses on the account" do
      expect(subject.client)
        .to receive(:use_image)
        .with("123456", ["test@example.com", "another@example.com"])

      subject.run
    end
  end
end
