require "brand_rotator/gravatar/action"
require "xmlrpc/client"

describe BrandRotator::Gravatar::Action do
  let(:xmlrpc_client) { double(XMLRPC::Client) }

  before do
    allow_any_instance_of(BrandRotator::Gravatar::Client)
      .to receive(:xmlrpc_client) { xmlrpc_client }
  end

  describe ".new" do
    it "creates a client instance" do
      action = BrandRotator::Gravatar::Action.new

      expect(action.client).to be_instance_of(BrandRotator::Gravatar::Client)
    end
  end
end
