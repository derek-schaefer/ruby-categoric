require 'spec_helper'

describe Categoric::Maybe do
  describe '#Maybe' do
    it { expect(Maybe 123).to eq Just(123) }
    it { expect(Maybe nil).to eq Nothing() }
  end

  describe '#Just' do
    it { expect(Just 42).to eq Just(42) }
    it { expect(Just Just(42)).to eq Just(42) }
  end

  describe '#Nothing' do
    it { expect(Nothing()).to eq Nothing() }
    it { expect(Nothing(Nothing())).to eq Nothing() }
  end

  describe '#from' do
    it { expect(Maybe.from nil).to eq Nothing() }
    it { expect(Maybe.from 123).to eq Just(123) }
    it { expect(Maybe.from Just(42)).to eq Just(42) }
    #it { expect(Maybe.from Nothing()).to eq Nothing() }
  end

  describe '.extract' do
    it { expect(Maybe(nil).extract).to be nil }
    it { expect(Maybe(123).extract).to eq 123 }
    it { expect(Nothing().extract).to be nil }
    it { expect(Just(123).extract).to eq 123 }
  end

  describe '._' do
    it { expect(Maybe(nil)._).to be nil }
    it { expect(Maybe(123)._).to eq 123 }
    it { expect(Nothing()._).to be nil }
    it { expect(Just(123)._).to eq 123 }
  end

  describe '.any?' do
    it { expect(Just(42).any?).to be true }
    it { expect(Nothing().any?).to be false }
  end

  describe '.empty?' do
    it { expect(Maybe(42).empty?).to be false }
    it { expect(Maybe(nil).empty?).to be true }
  end

  describe '.bind' do
    it { expect(Maybe(nil).bind(->(n) { n * 2 })).to eq Nothing() }
    it { expect(Maybe(123).bind(->(n) { n * 2 })).to eq Just(246) }
    it { expect(Maybe(nil).bind(->(n) { n * 2 }).bind(->(n) { n + 2 })).to eq Nothing() }
    it { expect(Maybe(123).bind(->(n) { n * 2 }).bind(->(n) { n + 2 })).to eq Just(248) }
  end

  describe '.>>' do
    it { expect(Maybe(nil) >> ->(n) { n * 2 }).to eq Nothing() }
    it { expect(Maybe(123) >> ->(n) { n * 2 }).to eq Just(246) }
    it { expect(Maybe(nil) >> ->(n) { n * 2 } >> ->(n) { n + 2 }).to eq Nothing() }
    it { expect(Maybe(123) >> ->(n) { n * 2 } >> ->(n) { n + 2 }).to eq Just(248) }
  end

  describe '.method_missing' do
    it { expect(Maybe(nil) * 2).to eq Nothing() }
    it { expect(Maybe(123) * 2).to eq Just(246) }
    it { expect(Maybe(nil) * 2 + 2).to eq Nothing() }
    it { expect(Maybe(123) * 2 + 2).to eq Just(248) }
  end

  describe '.==' do
    it { expect(Maybe(42) == Just(42)).to be true }
    it { expect(Maybe(42) == Nothing()).to be false }
    it { expect(Maybe(nil) == Just(42)).to be false }
    it { expect(Maybe(nil) == Nothing()).to be true }
  end

  describe '.to_a' do
    it { expect(Maybe(42).to_a).to eq [42] }
    it { expect(Maybe(nil).to_a).to eq [] }
  end

  describe '.name' do
    it { expect(Maybe(123).name).to eq 'Just' }
    it { expect(Maybe(nil).name).to eq 'Nothing' }
  end

  describe '.to_s' do
    it { expect(Maybe(42).to_s).to eq 'Just(42)' }
    it { expect(Maybe(nil).to_s).to eq 'Nothing()' }
  end
end
