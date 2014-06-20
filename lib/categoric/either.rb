module Categoric
  class Either
    include Monad

    def self.from(side, value)
      case side
      when :right then Right.new value
      when :left then Left.new value
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
    v = block ? block.call : value
    side = predicate.call v
    Either.from side, v
  end
end
