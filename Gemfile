# frozen_string_literal: true

source "https://rubygems.org"

gemspec

if ENV['CI'].nil?
  # for development
  gem "actionview"

else
  # for CI
  unless ENV['RAILS_VERSION'].blank?
    gem "actionview", "~> #{ENV['RAILS_VERSION']}"
  end
end
