require 'rubocop'
require 'rubocop/rails/model_callback/version'
module RuboCop::RSpec; end
require 'rubocop/rails/inject'

RuboCop::Rails::Inject.defaults!

require 'rubocop/cop/rails/model_callback'
