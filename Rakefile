# frozen_string_literal: true

require "bundler/gem_tasks"
require "rb_sys/extensiontask"
require "standard/rake"

task build: :compile

GEMSPEC = Gem::Specification.load("rs_floating_duration.gemspec")

RbSys::ExtensionTask.new("rs_floating_duration", GEMSPEC) do |ext|
  ext.lib_dir = "lib/rs_floating_duration"
end

task default: :compile

task examples: :build do
  require "rs_floating_duration"
  numbers = [
    0.5,
    0.001,
    0.02,
    10
  ]
  numbers.each do |number|
    puts "(#{number}s) => (short) #{RsFloatingDuration.time_format(number)} (long) #{RsFloatingDuration.time_format_long(number)}"
  end
end
