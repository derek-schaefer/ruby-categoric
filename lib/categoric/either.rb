module Categoric
  class Either
    include Monad
    extend  Monad::ClassMethods

    def self.from(side, value)
      if side then Right.join value
      else Left.join value end
    end

    def right?
      self.is_a? Right
    end

    def left?
      self.is_a? Left
    end

    def any?
      self.right?
    end
  end

  class Right < Either; end
  class Left < Either; end

  def Either(predicate, value = nil, &block)
    if value || block
      nvalue = block ? block.call : value
      Either.from(predicate.call(nvalue), nvalue)
    else
      ->(value = nil, &block) { Either(predicate, value, &block) }
    end
  end

  def Right(value = nil)
    Right.join value
  end

  def Left(value = nil)
    Left.join value
  end
end
