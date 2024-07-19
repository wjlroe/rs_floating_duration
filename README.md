# RsFloatingDuration

This is a simple Ruby gem that wraps the Rust Crate called
[floating_duration](https://github.com/torkleyy/floating-duration).

The primary purpose of this gem is as a minimal example of how to wrap a native
library in a ruby gem.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rs_floating_duration

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install rs_floating_duration

## Usage

Here's an example irb session illustrating how to use this gem:

```ruby
irb(main):001> require "rs_floating_duration"
=> true
irb(main):002> RsFloatingDuration.time_format(0.5)
=> "500.000ms"
irb(main):003> RsFloatingDuration.time_format_long(0.5)
=> "500.000 milliseconds"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

You will need rust installed to compile the extension.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to [rubygems.org]
(https://rubygems.org).
