module Categoric
  class Either
    include Monad
    extend  Monad::ClassMethods

    def self.from(side, value)
      if side then Right.join value
      else Left.join value end
    end

    def right?
      false
    end

    def left?
      false
    end
  end

  class Right < Either
    def any?
      true
    end

    def right?
      true
    end
  end

  class Left < Either
    def any?
      true
    end

    def left?
      true
    end
  end

  def Either(predicate, value = nil, &block)
    nvalue = block ? block.call : value
    Either.from(predicate.call(nvalue), nvalue)
  end

  def Right(value = nil)
    Right.join value
  end

  def Left(value = nil)
    Left.join value
  end
end
