module Categoric
  class Maybe
    include Monad

    def self.from(value)
      if value.nil?
        Nothing.new
      else
        Just.new value
      end
    end
  end

  class Just < Maybe
    def any?
      true
    end
  end

  class Nothing < Maybe
    def any?
      false
    end
  end

  def Maybe(value)
    Maybe.from value
  end
end
