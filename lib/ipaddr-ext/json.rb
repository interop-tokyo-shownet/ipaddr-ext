# frozen_string_literal: true

module IPAddrExt
  module JSON
    # Fix ActiveSupport::JSON.encode which remove the prefix address when encode with IPAddr/CIDR
    # https://github.com/rails/rails/issues/46006
    def self.remove_as_json
      if IPAddr.method_defined? :as_json
        IPAddr.remove_method :as_json
      end
    end

    def to_json
      format("\"%s\"", as_json)
    end

    def as_json(options = nil)
      if ipv4? && prefix == 32
        to_s
      elsif ipv6? && prefix == 128
        to_s
      else
        format("%s/%s", to_s, prefix)
      end
    end
  end
end
