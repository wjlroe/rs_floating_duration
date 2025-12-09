# frozen_string_literal: true

require "bundler/gem_tasks"
require "rb_sys/extensiontask"
require "rake_compiler_dock"

task build: :compile

GEMSPEC = Gem::Specification.load("rs_floating_duration.gemspec")

RbSys::ExtensionTask.new("rs_floating_duration", GEMSPEC) do |ext|
  ext.lib_dir = "lib/rs_floating_duration"

  ext.cross_compiling do |gemspec|
    # Override the ruby version because by default rake-compiler will set it to the version it compiled with
    # Since Ruby 3.2, it has a stable ABI, which means we don't need separate extensions per-ruby version
    gemspec.required_ruby_version = ">= 3.2.0"
  end
end

task default: :compile

CROSS_PLATFORMS = [
  "aarch64-linux",
  "x86_64-linux",
  "x86_64-darwin",
  "arm64-darwin"
]

RUBIES = "3.2" # Build with 3.2, uses stable ABI to work with 3.2, 3.3, 3.4+

desc "Build native extension for a given platform (i.e. `rake 'native[aarch64-linux]'`)"
task :native, [:platform] do |_t, args|
  platform = args[:platform] || raise("Must specify platform")
  sh "bundle", "exec", "rb-sys-dock", "--platform", platform, "--ruby-versions", RUBIES, "--build"
end

desc "Build cross-compiled gems for all platforms"
task :cross_compile do
  CROSS_PLATFORMS.each do |platform|
    puts "Building for platform: #{platform}"
    Rake::Task[:native].invoke(platform)
    Rake::Task[:native].reenable
  end
end

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
