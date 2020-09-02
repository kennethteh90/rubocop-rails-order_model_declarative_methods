# frozen_string_literal: true
# This file is copied from rubocop-rspec

module RuboCop
  # RuboCop RSpec project namespace
  module RSpec
    GEM_SPEC = Gem::Specification.find_by_name('rubocop-rails-order_model_declarative_methods')
    PROJECT_ROOT = GEM_SPEC.gem_dir
    CONFIG_DEFAULT = File.join(PROJECT_ROOT, 'config', 'default.yml').freeze
    CONFIG         = YAML.safe_load(CONFIG_DEFAULT).freeze

    private_constant(:CONFIG_DEFAULT, :PROJECT_ROOT)
  end
end
