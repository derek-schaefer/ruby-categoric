module Categoric
  class Try
    include Monad
    extend  Monad::ClassMethods

    def self.from(value)
      if value.nil? || value.is_a?(StandardError)
        Failure.join value
      else
        Success.join value
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
  end

  def Try(proc = nil, &block)
    f = (proc || block)

    begin
      Try.from f.call
    rescue => e
      Try.from e
    end
  end

  def Success(value)
    Success.join value
  end

  def Failure(value)
    Failure.join value
  end

end
