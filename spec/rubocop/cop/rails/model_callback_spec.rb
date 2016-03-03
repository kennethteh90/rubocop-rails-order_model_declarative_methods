require 'spec_helper'

describe RuboCop::Cop::Rails::OrderModelDeclarativeMethods do
  subject(:cop) { described_class.new }

  it '' do
    inspect_source(cop, [
      'class Foo',
      '  after_create :hoge',
      '  before_create :fuga',
      'end',
    ])
    expect(cop.messages).to eq ['not sorted']
    # expect(cop.highlights).to eq(['']) # TODO
    expect(cop.offenses.map(&:line).sort).to eq([2])
  end
end
