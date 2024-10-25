# frozen_string_literal: true

RSpec.describe "IPAddrExt::ActionView::TagHelper" do
  begin
    require 'action_view'
    include ActionView::Helpers::TagHelper
  rescue LoadError
    before do
      skip 'Does not depend on action_view gem'
    end
  end

  context "#tag_option" do
    it "tag options with ipaddr v4" do
      addr = IPAddr.new("192.0.2.0")

      expect(tag(:input, value: addr)).to eq "<input value=\"192.0.2.0\" />"
    end

    it "tag options with ipaddr v4 cidr" do
      addr = IPAddr.new("192.0.2.0/24")

      expect(tag(:input, value: addr)).to eq "<input value=\"192.0.2.0/24\" />"
    end

    it "tag options with ipaddr v6" do
      addr = IPAddr.new("2001:db8::")

      expect(tag(:input, value: addr)).to eq "<input value=\"2001:db8::\" />"
    end

    it "tag options with ipaddr v6 cidr" do
      addr = IPAddr.new("2001:db8::/32")

      expect(tag(:input, value: addr)).to eq "<input value=\"2001:db8::/32\" />"
    end
  end
end
