# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "irb"

if ENV['CI'].nil?
  # for development
  gem "actionview"

else
  # for CI
  unless ENV['RAILS_VERSION'].nil? || ENV['RAILS_VERSION'] == ''
    gem "actionview", "~> #{ENV['RAILS_VERSION']}.0"

    if ENV['RAILS_VERSION'] == '7.0' || ENV['RAILS_VERSION'] == '6.1'
      # Fix https://github.com/rails/rails/issues/54260
      gem "concurrent-ruby", "1.3.4"
    end

    if RUBY_VERSION >= '3.3'
      gem 'mutex_m'
      gem 'base64'
      gem 'bigdecimal'
      gem 'drb'
    end
    if RUBY_VERSION >= '3.4'
      gem 'benchmark'
      gem 'logger'
    end
  end
end
