require 'spec_helper'

describe Categoric::Monad do
  class Identity
    include Categoric::Monad
    extend  Categoric::Monad::ClassMethods
  end

  describe '#from' do
    it { expect(Identity.from 1).to eq Identity.new(1) }
    it { expect(Identity.from Identity.new(1)).to eq Identity.new(1) }
  end

  describe '#join' do
    it { expect(Identity.from 1).to eq Identity.new(1) }
    it { expect(Identity.from Identity.new(1)).to eq Identity.new(1) }
  end

  describe '.extract' do
    it { expect(Identity.new(1)._).to eq 1 }
    it { expect(Identity.new(nil)._).to eq nil }
  end

  describe '._' do
    it { expect(Identity.new(1)._).to eq 1 }
    it { expect(Identity.new(nil)._).to eq nil }
  end

  describe '.any?' do
    it { expect(Identity.new(1).any?).to be false }
  end

  describe '.empty?' do
    it { expect(Identity.new(1).empty?).to be true }
  end

  describe '.bind' do
    it { expect(Identity.new(1).bind(->(n) { n * 2 })).to eq Identity.new(1) }
    it { expect(Identity.new(nil).bind(->(n) { n * 2 })).to eq Identity.new(nil) }
  end

  describe '.>>' do
    it { expect(Identity.new(1) >> ->(n) { n * 2 }).to eq Identity.new(1) }
    it { expect(Identity.new(nil) >> ->(n) { n * 2 }).to eq Identity.new(nil) }
  end

  describe '.method_missing' do
    it { expect(Identity.new(1) * 2).to eq Identity.new(1) }
    it { expect(Identity.new(nil) * 2).to eq Identity.new(nil) }
  end

  describe '.==' do
    it { expect(Identity.new(1) == Identity.new(1)).to be true }
    it { expect(Identity.new(1) == Identity.new(2)).to be false }
  end

  describe '.to_a' do
    it { expect(Identity.new(1).to_a).to eq [] }
  end

  describe '.name' do
    it { expect(Identity.new(1).name).to eq 'Identity' }
  end

  describe '.to_s' do
    it { expect(Identity.new(1).to_s).to eq 'Identity(1)' }
    it { expect(Identity.new(nil).to_s).to eq 'Identity()' }
  end

  describe '.try_any?' do
    it { expect(Identity.new.send(:try_any?, Identity.new(1))).to be false }
  end

  describe '.try_empty?' do
    it { expect(Identity.new.send(:try_empty?, Identity.new(1))).to be true }
  end

  describe '.nil_or_empty?' do
    it { expect(Identity.new.send(:nil_or_empty?, nil)).to be true }
    it { expect(Identity.new.send(:nil_or_empty?, Identity.new(1))).to be true }
  end
end
