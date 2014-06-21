require 'spec_helper'

describe Categoric::Try do
  describe '#Try' do
    it { expect(Try(2)).to eq Success(2) }
    it { expect(Try(nil)).to eq Success() }
    it { expect(Try(TypeError.new)).to eq Failure(TypeError.new) }
    it { expect(Try(->{ 1 + 1 })).to eq Success(2) }
    it { expect(Try(->{ 1 + nil })).to eq Failure(TypeError.new) }
  end

  describe '#Success' do
    it { expect(Success(2)).to eq Success(2) }
    it { expect(Success(Success(2))).to eq Success(2) }
  end

  describe '#Failure' do
    it { expect(Failure(TypeError.new)).to eq Failure(TypeError.new) }
    it { expect(Failure(Failure(TypeError.new))).to eq Failure(TypeError.new) }
  end

  describe '#from' do
    it { expect(Try.from(->{ 1 + 1 })).to eq Success(2) }
    it { expect(Try.from(->{ 1 + nil })).to eq Failure(TypeError.new) }
    it { expect(Try.from(->{ 1 + 1 }) >> ->(n) { Try(->{ n + nil }) }).to eq Failure(TypeError.new) }
    it { expect(Try.from(Success(42))).to eq Success(42) }
    it { expect(Try.from(Failure(TypeError.new))).to eq Failure(TypeError.new) }
  end

  describe '.extract' do
    it { expect(Try(->{ 1 + 1 }).extract).to eq 2 }
    it { expect(Try(->{ 1 + nil }).extract).to be_a TypeError }
    it { expect(Success(42).extract).to eq 42 }
    it { expect(Failure(TypeError.new).extract).to be_a TypeError }
  end

  describe '._' do
    it { expect(Try(->{ 1 + 1 })._).to eq 2 }
    it { expect(Try(->{ 1 + nil })._).to be_a TypeError }
    it { expect(Success(42)._).to eq 42 }
    it { expect(Failure(TypeError.new)._).to be_a TypeError }
  end

  describe '.any?' do
    it { expect(Success(42).any?).to be true }
    it { expect(Failure(TypeError.new).any?).to be false }
  end

  describe '.empty?' do
    it { expect(Success(42).empty?).to be false }
    it { expect(Failure(TypeError.new).empty?).to be true }
  end

  describe '.bind' do
    it { expect(Try(2).bind(->(n) { n + 2 })).to eq Success(4) }
    it { expect(Try(->{ 1 + nil }).bind(->(n) { n + 2 })).to eq Failure(TypeError.new) }
    it { expect(Try(->{ 1 + 1 }).bind(->(n) { Try(->{ n + nil }) })).to eq Failure(TypeError.new) }
  end

  describe '.>>' do
    it { expect(Try(2) >> ->(n) { n + 2 }).to eq Success(4) }
    it { expect(Try(->{ 1 + nil }) >> ->(n) { n + 2 }).to eq Failure(TypeError.new) }
    it { expect(Try(->{ 1 + 1 }) >> ->(n) { Try(->{ n + nil }) }).to eq Failure(TypeError.new) }
  end

  describe '.method_missing' do
    it { expect(Try(2) + 2).to eq Success(4) }
    it { expect(Try(->{ 1 + nil }) + 2).to eq Failure(TypeError.new) }
    it { expect(Try(->{ 1 + 1 }) * 2 + 2).to eq Success(6) }
    it { expect(Try(->{ 1 + nil }) + 2 + 1).to eq Failure(TypeError.new) }
  end

  describe '.==' do
    it { expect(Try(2) == Success(2)).to be true }
    it { expect(Try(2) == Success(3)).to be false }
    it { expect(Try(2) == Failure(2)).to be false }
    it { expect(Try(nil) == Success(2)).to be false }
    it { expect(Try(nil) == Failure(2)).to be false }
    it { expect(Try(nil) == Failure()).to be false }
    it { expect(Try(TypeError.new) == Failure(TypeError.new)).to be true }
    it { expect(Try(TypeError.new('asdf')) == Failure(TypeError.new)).to be true }
    it { expect(Try(TypeError.new('asdf')) == Failure(TypeError.new('asdf'))).to be true }
  end

  describe '.to_a' do
    it { expect(Try(2).to_a).to eq [2] }
    it { expect(Try(TypeError.new).to_a).to eq [] }
  end

  describe '.name' do
    it { expect(Try(2).name).to eq 'Success' }
    it { expect(Try(TypeError.new).name).to eq 'Failure' }
  end

  describe '.to_s' do
    it { expect(Try(2).to_s).to eq 'Success(2)' }
    it { expect(Try(nil).to_s).to eq 'Success()' }
    it { expect(Try(TypeError.new).to_s).to eq 'Failure(TypeError)' }
  end
end
