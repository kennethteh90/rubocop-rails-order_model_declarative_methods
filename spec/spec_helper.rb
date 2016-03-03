# This file is copied from rubocop-rspec

require 'rubocop'

rubocop_path = File.expand_path(ENV['RUBOCOP_PATH'] || '~/ghq/github.com/bbatsov/rubocop')

unless File.directory?(rubocop_path)
  raise "#{rubocop_path} is not directory"
end

Dir["#{rubocop_path}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = :random

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect # Disable `should`
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect # Disable `should_receive` and `stub`
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubocop-rails-model_callback'
