require 'spec_helper'

describe Categoric::Either do
  def match_class(e)
    case e
    when Right then :right
    when Left then :left
    end
  end

  describe 'Either' do
    it { expect(Either(->(n) { n > 0 }, 2)).to eq Right(2) }
    it { expect(Either(->(n) { n > 0 }, 0)).to eq Left(0) }
    it { expect(Either(->(n) { n > 0 }, -2)).to eq Left(-2) }
    it { expect(Either(->(n) { n > 0 }) { 2 + 2 }).to eq Right(4) }
    it { expect(Either(->(n) { n > 0 }) { -2 * 2}).to eq Left(-4) }
    it { expect(match_class Either(->(n) { n > 0 }, 2)).to eq :right }
    it { expect(match_class Either(->(n) { n > 0 }, -2)).to eq :left }
  end

  describe 'Right' do
    it { expect(Right 42).to eq Right(42) }
    it { expect(Right Right(42)).to eq Right(42) }
  end

  describe 'Left' do
    it { expect(Left 42).to eq Left(42) }
    it { expect(Left Left(42)).to eq Left(42) }
  end

  describe '#right?' do
    it { expect(Either(->(n) { n > 0 }, 2).right?).to be true }
    it { expect(Either(->(n) { n > 0 }, -2).right?).to be false }
  end

  describe '#left?' do
    it { expect(Either(->(n) { n > 0 }, 2).left?).to be false }
    it { expect(Either(->(n) { n > 0 }, -2).left?).to be true }
  end
end
