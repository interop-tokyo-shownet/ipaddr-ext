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

  context "#+" do
    it "ipv4" do
      expect((IPAddr.new("192.168.1.2") + 10).to_s_with_prefix).to eq '192.168.1.12/32'
      expect((IPAddr.new("192.168.1.0/24") + 10).to_s_with_prefix).to eq '192.168.1.10/24'

      expect{ IPAddr.new("255.255.255.255") + 1 }.to raise_error IPAddr::InvalidAddressError
    end

    it "ipv6" do
      expect((IPAddr.new("3ffe:505:2::1") + 10).to_s_with_prefix).to eq '3ffe:505:2::b/128'
      expect((IPAddr.new("3ffe:505:2::/64") + 10).to_s_with_prefix).to eq '3ffe:505:2::a/64'
    end
  end

  context "#-" do
    it "ipv4" do
      expect((IPAddr.new("192.168.1.2") - 1).to_s_with_prefix).to eq '192.168.1.1/32'
      expect((IPAddr.new("192.168.1.0/24") - 1).to_s_with_prefix).to eq '192.168.0.255/24'

      expect{ IPAddr.new("0.0.0.0") - 1 }.to raise_error IPAddr::InvalidAddressError
    end

    it "ipv6" do
      expect((IPAddr.new("3ffe:505:2::1") - 1).to_s_with_prefix).to eq '3ffe:505:2::/128'
      expect((IPAddr.new("3ffe:505:2::/64") - 1).to_s_with_prefix).to eq '3ffe:505:1:ffff:ffff:ffff:ffff:ffff/64'
    end
  end

  context "#to_host" do
    it "ipv4" do
      expect(IPAddr.new("192.168.1.0/24").to_host).to eq '192.168.1.0/32'
      expect(IPAddr.new("192.168.1.0/24").succ.to_host).to eq '192.168.1.1/32'
      expect(IPAddr.new("192.168.1.2").to_host).to eq '192.168.1.2/32'
    end

    it "ipv6" do
      expect(IPAddr.new("3ffe:505:2::/64").to_host).to eq '3ffe:505:2::/128'
      expect(IPAddr.new("3ffe:505:2::/64").succ.to_host).to eq '3ffe:505:2::1/128'
      expect(IPAddr.new("3ffe:505:2::1").to_host).to eq '3ffe:505:2::1/128'
    end
  end

  context "#to_s_with_prefix" do
    it "ipv4" do
      expect(IPAddr.new("192.168.1.2").to_s_with_prefix).to eq '192.168.1.2/32'
      expect(IPAddr.new("192.168.1.0/24").to_s_with_prefix).to eq '192.168.1.0/24'
    end

    it "ipv6" do
      expect(IPAddr.new("3ffe:505:2::1").to_s_with_prefix).to eq '3ffe:505:2::1/128'
      expect(IPAddr.new("3ffe:505:2::/64").to_s_with_prefix).to eq '3ffe:505:2::/64'
    end
  end
end
