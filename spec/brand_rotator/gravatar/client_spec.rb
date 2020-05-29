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
