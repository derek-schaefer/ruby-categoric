require 'spec_helper'

describe Categoric::Try do
  describe '#Try' do
    it { expect(Try(->{ 1 + 1 })).to eq Success(2) }
    #it { expect(Try(->{ 1 + nil })).to eq Failure(TypeError.new("nil can't be coerced into Fixnum")) }
  end

  describe '#Success' do
    it { expect(Success(2)).to eq Success(2) }
    it { expect(Success(Success(2))).to eq Success(2) }
  end

  describe '#Failure' do
    it { expect(Failure(TypeError.new)).to eq Failure(TypeError.new) }
    it { expect(Failure(Failure(TypeError.new))).to eq Failure(TypeError.new) }
  end
end
