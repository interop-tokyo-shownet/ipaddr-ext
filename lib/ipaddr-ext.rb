require "ipaddr"
require 'json'

require "ipaddr-ext/version"
require "ipaddr-ext/extensions"
require "ipaddr-ext/json"

IPAddr.send(:include, IPAddrExt::Extensions)
IPAddr.send(:include, IPAddrExt::JSON)
