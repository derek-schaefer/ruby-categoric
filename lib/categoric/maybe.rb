module Categoric
  class Maybe
    include Monad
    extend  Monad::ClassMethods

    def self.from(value)
      if value.nil? || value.is_a?(Nothing)
        Nothing.new
      else
        Just.join value
      end
    end

    def just?
      self.is_a? Just
    end

    def nothing?
      self.is_a? Nothing
    end

    def any?
      self.just?
    end
  end

  class Just < Maybe; end
  class Nothing < Maybe; end

  def Maybe(value)
    Maybe.from value
  end

  def Just(value)
    Just.join value
  end

  def Nothing(value = nil)
    Nothing.new
  end
end
