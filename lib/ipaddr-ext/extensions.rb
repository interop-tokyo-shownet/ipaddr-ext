# frozen_string_literal: true

require_relative "version"

module IPAddrExt
  module Extensions
    # Returns the wildcard mask in string format e.g. 0.0.255.255
    # ref: https://github.com/ruby/ipaddr/pull/44
    def wildcard_mask
      case @family
      when Socket::AF_INET
        mask = IPAddr::IN4MASK ^ @mask_addr
      when Socket::AF_INET6
        mask = IPAddr::IN6MASK ^ @mask_addr
      else
        raise AddressFamilyError, "unsupported address family"
      end

      _to_string(mask)
    end
  end
end
