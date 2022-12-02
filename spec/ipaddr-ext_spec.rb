# frozen_string_literal: true

RSpec.describe IPAddrExt do
  it "has a version number" do
    expect(IPAddrExt::VERSION).not_to be nil
  end

  context "#broadcast" do
    it "ipv4" do
      expect(IPAddr.new("192.168.1.2/8").broadcast).to eq "192.255.255.255"
      expect(IPAddr.new("192.168.1.2/16").broadcast).to eq "192.168.255.255"
      expect(IPAddr.new("192.168.1.2/24").broadcast).to eq "192.168.1.255"
      expect(IPAddr.new("192.168.1.2/32").broadcast).to eq "192.168.1.2"
    end

    it "ipv6" do
      expect(IPAddr.new("3ffe:505:2::/48").broadcast).to eq nil
      expect(IPAddr.new("3ffe:505:2::/128").broadcast).to eq nil
    end
  end

  context "#wildcard_mask" do
    it "ipv4" do
      expect(IPAddr.new("192.168.1.2/1").wildcard_mask).to eq "127.255.255.255"
      expect(IPAddr.new("192.168.1.2/8").wildcard_mask).to eq "0.255.255.255"
      expect(IPAddr.new("192.168.1.2/16").wildcard_mask).to eq "0.0.255.255"
      expect(IPAddr.new("192.168.1.2/24").wildcard_mask).to eq "0.0.0.255"
      expect(IPAddr.new("192.168.1.2/32").wildcard_mask).to eq "0.0.0.0"
    end

    it "ipv6" do
      expect(IPAddr.new("3ffe:505:2::/48").wildcard_mask).to eq "0000:0000:0000:ffff:ffff:ffff:ffff:ffff"
      expect(IPAddr.new("3ffe:505:2::/128").wildcard_mask).to eq "0000:0000:0000:0000:0000:0000:0000:0000"
    end
  end
end
