# frozen_string_literal: true

module IPAddrExt
  module JSON
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
