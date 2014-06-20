module Categoric
  class Try
    include Monad

    def self.from(value)
      if value.nil? || value.is_a?(StandardError)
        Failure.new value
      else
        Success.new value
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
      Success.new f.call
    rescue => e
      Failure.new e
    end
  end
end
