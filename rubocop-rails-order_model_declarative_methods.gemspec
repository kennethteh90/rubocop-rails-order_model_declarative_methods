# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/rails/order_model_declarative_methods/version'

Gem::Specification.new do |spec|
  spec.name          = "rubocop-rails-order_model_declarative_methods"
  spec.version       = Rubocop::Rails::OrderModelDeclarativeMethods::VERSION
  spec.authors       = ["Masataka Kuwabara"]
  spec.email         = ["p.ck.t22@gmail.com"]

  spec.summary       = %q{Sort declarative methods of Rails model, as an extension to RuboCop.}
  spec.description   = %q{Sort declarative methods of Rails model, as an extension to RuboCop.}
  spec.homepage      = "https://github.com/pocke/rubocop-rails-order_model_declarative_methods"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license = 'CC0-1.0'

  spec.add_runtime_dependency 'rubocop', '~> 0.89'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "guard", "~> 2.13.0"
  spec.add_development_dependency "guard-bundler", "~> 2.1.0"
  spec.add_development_dependency "guard-rspec", "~> 4.6.4"
  spec.add_development_dependency "guard-rake", "~> 1.0.0"
end
