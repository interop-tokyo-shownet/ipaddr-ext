# frozen_string_literal: true

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

    unless defined?(IPAddr::VERSION) && Gem::Version.new(IPAddr::VERSION) >= Gem::Version.new("1.2.7") # Ruby 3.4+ default gem
      # Returns the wildcard mask in string format e.g. 0.0.255.255
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

    # Returns true if two ipaddrs are equal.
    # Overwrite original == method, fixing to compare address with prefix
    def ==(other)
      other = coerce_other(other)
    rescue
      false
    else
      @family == other.family && @addr == other.to_i && prefix == other.prefix
    end

    # Returns a address greater than the original address by offset
    # @param offset [Integer]
    def +(offset)
      self.clone.set(@addr + offset, @family)
    end

    # Returns a address less than the original address by offset
    # @param offset [Integer]
    def -(offset)
      self.clone.set(@addr - offset, @family)
    end

    # Returns the host address
    def to_host
      case @family
      when Socket::AF_INET
        self.mask(32)
      when Socket::AF_INET6
        self.mask(128)
      else
        raise AddressFamilyError, "unsupported address family"
      end
    end

    # Returns the address with prefix
    def to_s_with_prefix
      if defined?(IPAddr::VERSION) && Gem::Version.new(IPAddr::VERSION) >= Gem::Version.new("1.2.7") # Ruby 3.4+ default gem
        cidr
      else
        "#{self.to_s}/#{prefix}"
      end
    end
  end
end
