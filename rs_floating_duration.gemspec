# frozen_string_literal: true

require_relative "lib/rs_floating_duration/version"

Gem::Specification.new do |spec|
  spec.name = "rs_floating_duration"
  spec.version = RsFloatingDuration::VERSION
  spec.authors = ["William Roe"]
  spec.email = ["rubygems@wjlr.org.uk"]
  spec.licenses = ["MIT"]

  spec.summary = "A wrapper around Rust's floating_duration crate"
  spec.description = "The floating_duration crate can format time durations as strings"
  spec.homepage = "https://github.com/wjlroe/rs_floating_duration"
  spec.required_ruby_version = ">= 2.6.0"
  spec.required_rubygems_version = ">= 3.3.11"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile .github])
    end # + Dir.glob("lib/**/*.{so,bundle}")
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ["ext/rs_floating_duration/Cargo.toml"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
