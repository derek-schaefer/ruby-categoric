module Categoric
  class Either
    include Monad
    extend  Monad::ClassMethods

    def self.from(side, value)
      case side
      when :right then Right.join value
      when :left then Left.join value
      else raise "Invalid side: #{side}"
      end
    end
  end

  class Right < Either
    def any?
      true
    end
  end

  class Left < Either
    def any?
      true
    end
  end

  def Either(predicate, value = nil, &block)
    nvalue = block ? block.call : value
    Either.join(predicate.call nvalue, nvalue)
  end
end
