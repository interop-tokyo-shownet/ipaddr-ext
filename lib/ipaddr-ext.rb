require "ipaddr"
require 'json'

require "ipaddr-ext/version"
require "ipaddr-ext/extensions"
require "ipaddr-ext/json"

IPAddr.send(:prepend, IPAddrExt::Extensions)

IPAddrExt::JSON.remove_as_json
IPAddr.send(:include, IPAddrExt::JSON)
