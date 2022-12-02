# frozen_string_literal: true

require_relative "version"

module IPAddrExt
  module Extensions
    # Returns the broadcast address
    def broadcast
      case @family
      when Socket::AF_INET
        unless prefix == 32
          broadcast_addr = @addr + (IPAddr::IN4MASK ^ @mask_addr)
          return self.clone.set(broadcast_addr, @family)
        else
          return self.clone
        end

      when Socket::AF_INET6
        nil

      else
        raise AddressFamilyError, "unsupported address family"
      end
    end

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

    # Returns the address with prefix
    def to_s_with_prefix
      "#{self.to_s}/#{prefix}"
    end
  end
end
