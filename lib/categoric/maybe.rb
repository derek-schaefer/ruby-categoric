module Categoric
  class Maybe
    include Monad
    extend  Monad::ClassMethods

    # TODO: join if Nothing
    def self.from(value)
      if value.nil?
        Nothing.new
      else
        Just.join value
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

  def Just(value)
    Just.join value
  end

  def Nothing
    Nothing.new
  end
end
