# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
Warning[:deprecated] = false

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
