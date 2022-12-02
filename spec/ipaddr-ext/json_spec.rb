# frozen_string_literal: true

RSpec.describe IPAddrExt::JSON do
  context "#to_json" do
    it "ipv4" do
      expect(IPAddr.new("192.168.1.1").to_json).to eq "\"192.168.1.1\""
      expect(IPAddr.new("192.168.1.2/32").to_json).to eq "\"192.168.1.2\""
      expect(IPAddr.new("192.168.1.0/24").to_json).to eq "\"192.168.1.0/24\""
    end

    it "ipv6" do
      expect(IPAddr.new("3ffe:505:2::1").to_json).to eq "\"3ffe:505:2::1\""
      expect(IPAddr.new("3ffe:505:2::2/128").to_json).to eq "\"3ffe:505:2::2\""
      expect(IPAddr.new("3ffe:505:2::/64").to_json).to eq "\"3ffe:505:2::/64\""
    end
  end
end
