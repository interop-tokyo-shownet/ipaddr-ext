# frozen_string_literal: true

module IPAddrExt
  module JSON
    def to_json
      if ipv4? && prefix == 32
        format("\"%s\"", to_s)
      elsif ipv6? && prefix == 128
        format("\"%s\"", to_s)
      else
        format("\"%s/%s\"", to_s, prefix)
      end
    end
  end
end
