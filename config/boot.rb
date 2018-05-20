# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

require 'bootsnap'
env = ENV['RAILS_ENV'] || 'development'

Bootsnap.setup(
  cache_dir: 'tmp/cache',
  development_mode: env == 'development',
  load_path_cache: true,
  autoload_paths_cache: true,
  disable_trace: true,
  compile_cache_iseq: false,
  compile_cache_yaml: true
)
