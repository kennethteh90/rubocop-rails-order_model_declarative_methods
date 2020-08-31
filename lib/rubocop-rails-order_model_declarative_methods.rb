require 'rubocop'
require 'rubocop/rails/order_model_declarative_methods/version'
require 'rubocop/rspec'
require 'rubocop/rspec/inject'

RuboCop::RSpec::Inject.defaults!

require 'rubocop/cop/rails/order_model_declarative_methods'
