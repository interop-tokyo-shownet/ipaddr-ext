# frozen_string_literal: true

source "https://rubygems.org"

gemspec

if ENV['CI'].nil?
  # for development
  gem "actionview"

else
  # for CI
  unless ENV['RAILS_VERSION'].nil? || ENV['RAILS_VERSION'] == ''
    gem "actionview", "~> #{ENV['RAILS_VERSION']}.0"
  end
end
