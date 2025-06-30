# frozen_string_literal: true

require "bundler/gem_tasks"
require "rb_sys/extensiontask"
require "rake_compiler_dock"
require "standard/rake"

task build: :compile

GEMSPEC = Gem::Specification.load("rs_floating_duration.gemspec")

RbSys::ExtensionTask.new("rs_floating_duration", GEMSPEC) do |ext|
  ext.lib_dir = "lib/rs_floating_duration"
end

task default: :compile

CROSS_PLATFORMS = [
  "aarch64-linux",
  "x86_64-linux",
  "x86_64-darwin",
  "arm64-darwin"
]

desc "Build native extension for a given platform (i.e. `rake 'native[aarch64-linux]'`)"
task :native, [:platform] do |_t, args|
  platform = args[:platform] || raise("Must specify platform")
  sh 'bundle', 'exec', 'rb-sys-dock', '--platform', platform, '--ruby-versions', '2.7,3.0,3.1,3.2,3.3', '--build'
end

desc "Build cross-compiled gems for all platforms"
task :cross_compile do
  CROSS_PLATFORMS.each do |platform|
    puts "Building for platform: #{platform}"
    Rake::Task[:native].invoke(platform)
    Rake::Task[:native].reenable
  end
end

namespace "gem" do
  CROSS_PLATFORMS.each do |platform|
    desc "Build gem for #{platform}"
    task platform do
      sh 'bundle', 'exec', 'rb-sys-dock', '--platform', platform, '--ruby-versions', '2.7,3.0,3.1,3.2,3.3', '--build'
    end
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
