require "ipaddr"

require "ipaddr-ext/version"
require "ipaddr-ext/extensions"
require "ipaddr-ext/json"

IPAddr.send(:prepend, IPAddrExt::Extensions)

IPAddrExt::JSON.remove_as_json
IPAddr.send(:include, IPAddrExt::JSON)

if defined?(::ActionView) && ActionView.version >= Gem::Version.new("6.1.0")
  require "ipaddr-ext/actionview/tag_helper"
end
