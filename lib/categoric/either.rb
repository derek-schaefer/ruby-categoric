module Categoric
  class Either
    include Monad
    extend  Monad::ClassMethods

    def self.from(predicate, value = nil, &block)
      if value || block
        nvalue = block ? block.call : value
        side = (predicate.call(nvalue) ? Right : Left).join nvalue
        side.predicate = predicate
        side
      else
        ->(value = nil, &block) { Either(predicate, value, &block) }
      end
    end

    def right?
      self.is_a? Right
    end

    def left?
      self.is_a? Left
    end

    def any?
      true
    end

    def right(f = nil, &block)
      (self.right? ? self.bind(f, &block) : self)
    end

    def left(f = nil, &block)
      (self.left? ? self.bind(f, &block) : self)
    end

    def predicate=(p)
      @predicate = p if p && !@predicate
    end

    def bind(f = nil, &block)
      self.class.from @predicate, self._bind((f || block))
    end
  end

  class Right < Either; end
  class Left < Either; end

  def Either(predicate, value = nil, &block)
    Either.from predicate, value, &block
  end

  def Right(value = nil)
    Right.join value
  end

  def Left(value = nil)
    Left.join value
  end
end
