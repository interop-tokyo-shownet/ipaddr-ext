# frozen_string_literal: true

require 'action_view'

module ActionView
  module Helpers
    module TagHelper
      class TagBuilder
        # Overwrite to fix FormHelper#text_field build value attribute of IPAddr without prefix
        # https://github.com/rails/rails/pull/52365
        def tag_option(key, value, escape)
          key = ERB::Util.xml_name_escape(key) if escape

          case value
          when Array, Hash
            value = TagHelper.build_tag_values(value) if key.to_s == "class"
            value = escape ? safe_join(value, " ") : value.join(" ")
          when Regexp
            value = escape ? ERB::Util.unwrapped_html_escape(value.source) : value.source
          when IPAddr
            addr = value.to_s
            unless (value.ipv4? && value.prefix == 32) || (value.ipv6? && value.prefix == 128)
              addr = format("%s/%s", value.to_s, value.prefix)
            end

            value = escape ? ERB::Util.unwrapped_html_escape(addr) : addr
          else
            value = escape ? ERB::Util.unwrapped_html_escape(value) : value.to_s
          end
          value = value.gsub('"', "&quot;") if value.include?('"')

          %(#{key}="#{value}")
        end
      end
    end
  end
end
