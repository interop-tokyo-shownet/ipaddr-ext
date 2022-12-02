require "ipaddr"
require "ipaddr-ext/extensions"

IPAddr.send(:include, IPAddrExt::Extensions)
