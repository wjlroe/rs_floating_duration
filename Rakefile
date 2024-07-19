# frozen_string_literal: true

require "bundler/gem_tasks"
require "rb_sys/extensiontask"
require "standard/rake"

task build: :compile

GEMSPEC = Gem::Specification.load("rs_floating_duration.gemspec")

RbSys::ExtensionTask.new("rs_floating_duration", GEMSPEC) do |ext|
  ext.lib_dir = "lib/rs_floating_duration"
  ext.cross_compile = true
  ext.cross_platform = [
    "aarch64-linux",
    "x86_64-linux",
    "arm64-darwin"
  ]
end

task default: :compile

task examples: :build do
  require "bundler/setup"
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

task :gem_filename do
  platform = Gem::Platform.new(RUBY_PLATFORM).to_s
  latest_gem = Dir.glob("pkg/rs_floating_duration-*-#{platform}.gem").sort.last
  raise "Couldn't find a gem for platform: #{platform}!" if latest_gem.nil?
  puts "GEM_FILENAME=#{File.basename(latest_gem)}"
end
