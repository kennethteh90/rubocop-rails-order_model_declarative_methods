require 'spec_helper'

RSpec.describe RuboCop::Cop::Rails::OrderModelDeclarativeMethods do
  subject(:cop) { described_class.new }

  it 'flags a model whose declarative methods are not sorted' do
    expect_offense(<<-RUBY)
      class User < ApplicationRecord
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ not sorted
        has_many :foos
        belongs_to :bar
      end
    RUBY
  end

  it 'does not flag a model whose declarative methods are sorted' do
    expect_no_offenses(<<-RUBY)
      class User < ApplicationRecord
        belongs_to :bar
        has_many :foos
      end
    RUBY
  end
end
