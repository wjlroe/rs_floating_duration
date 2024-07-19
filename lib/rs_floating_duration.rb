# frozen_string_literal: true

require_relative "rs_floating_duration/version"
begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require_relative "#{$1}/rs_floating_duration/rs_floating_duration"
rescue LoadError
  require "rs_floating_duration/rs_floating_duration"
end

module RsFloatingDuration
  class Error < StandardError; end
  # Your code goes here...
end
