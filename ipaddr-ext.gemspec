# frozen_string_literal: true

require_relative "lib/ipaddr-ext/version"

Gem::Specification.new do |spec|
  spec.name = "ipaddr-ext"
  spec.version = IPAddrExt::VERSION
  spec.authors = ["Taketo Takashima"]
  spec.email = ["t.taketo1113@gmail.com"]

  spec.summary = "Extensions for IPAddr Class"
  spec.description = "Extensions for IPAddr Class"
  spec.homepage = "http://example.com" # TODO
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rspec", ">= 3.0"
end
