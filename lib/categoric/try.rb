module Categoric
  class Try
    include Monad
    extend  Monad::ClassMethods

    def self.from(f)
      if f.is_a? Proc
        begin
          value = f.call
          if value.class <= self then self.from value
          else Success.join value end
        rescue => e
          Failure.new e
        end
      elsif f.is_a?(StandardError) || f.is_a?(Failure)
        Failure.join f
      else
        Success.join f
      end
    end
  end

  class Success < Try
    def any?
      true
    end
  end

  class Failure < Try
    def any?
      false
    end

    def ==(other)
      other.is_a?(self.class) && (other._ == @value || other._.is_a?(@value.class))
    end
  end

  def Try(f = nil, &block)
    Try.from(f || block)
  end

  def Success(value = nil)
    Success.join value
  end

  def Failure(value = nil)
    Failure.join value
  end

end
