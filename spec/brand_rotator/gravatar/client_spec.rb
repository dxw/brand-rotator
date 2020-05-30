require "brand_rotator/gravatar/client"
require "xmlrpc/client"

describe BrandRotator::Gravatar::Client do
  let(:xmlrpc_client) { double(XMLRPC::Client) }

  describe ".new" do
    it "creates a XMLRPC client instance" do
      client = BrandRotator::Gravatar::Client.new

      expect(client.xmlrpc_client).to be_instance_of(XMLRPC::Client)
    end
  end

  describe "#addresses" do
    let(:addresses_response) {
      {
        "test@example.com" => {
          "rating" => 0,
          "userimage" => "123456",
          "userimage_url" => "http://en.gravatar.com/userimage/12345678/123456.jpg"
        },
        "another@example.com" => {
          "rating" => 0,
          "userimage" => "654321",
          "userimage_url" => "http://en.gravatar.com/userimage/12345678/654321.jpg"
        }
      }
    }

    before do
      allow_any_instance_of(BrandRotator::Gravatar::Client)
        .to receive(:xmlrpc_client) { xmlrpc_client }
    end

    it "fetches the email addresses associated with the account" do
      expect(subject.xmlrpc_client)
        .to receive(:call)
          .with("grav.addresses", instance_of(Hash)) { addresses_response }

      subject.addresses
    end

    it "returns an array of email addresses" do
      allow(subject.xmlrpc_client)
        .to receive(:call)
          .with("grav.addresses", instance_of(Hash)) { addresses_response }

      expect(subject.addresses)
        .to eq(["test@example.com", "another@example.com"])
    end
  end

  describe "#upload_image!" do
    before do
      allow_any_instance_of(BrandRotator::Gravatar::Client)
        .to receive(:xmlrpc_client) { xmlrpc_client }
    end

    it "uploads a new image" do
      expect(subject.xmlrpc_client)
        .to receive(:call)
        .with(
          "grav.saveData",
          hash_including(data: instance_of(String), rating: 0)
        )

      subject.upload_image!(File.join("..", "spec", "fixtures", "image"))
    end
  end

  describe "#use_image!" do
    before do
      allow_any_instance_of(BrandRotator::Gravatar::Client)
        .to receive(:xmlrpc_client) { xmlrpc_client }
    end

    it "assigns the image to the provided addresses" do
      image_id = "123456"
      addresses = ["test@example.com", "another@example.com"]

      expect(subject.xmlrpc_client)
        .to receive(:call)
        .with(
          "grav.useUserimage",
          hash_including(userimage: image_id, addresses: addresses)
        )

      subject.use_image!(image_id, addresses)
    end
  end

  describe "#test" do
    before do
      allow_any_instance_of(BrandRotator::Gravatar::Client)
        .to receive(:xmlrpc_client) { xmlrpc_client }
    end

    it "runs a client test" do
      expect(subject.xmlrpc_client)
        .to receive(:call)
        .with("grav.test", {password: "GRAVATAR_PASSWORD", test: true})

      subject.test
    end
  end
end
