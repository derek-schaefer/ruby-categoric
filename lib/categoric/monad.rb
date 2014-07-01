module Categoric
  module Monad
    module ClassMethods
      # Create a new monad with the value
      def from(value)
        self.join value
      end

      # Combine monads of the same type
      def join(other)
        self.new(other.class <= self ? other._ : other)
      end
    end

    # Create a new monad with the value
    def initialize(value = nil)
      @value = value
    end

    # Extract the boxed value
    def extract
      @value
    end

    alias :_ :extract

    # Does the monad contain a value?
    def any?
      false
    end

    # Does the monad contain nothing?
    def empty?
      !self.any?
    end

    # Transform the boxed value
    def bind(f = nil, &block)
      self.class.from self._bind((f || block))
    end

    alias :>> :bind

    # Send other method calls to the boxed value via bind
    def method_missing(m, *args)
      self.bind { |v| v.__send__(m, *args) }
    end

    # Monad type and value comparison
    def ==(other)
      other.is_a?(self.class) && other._ == @value
    end

    # Either an empty or single-element array
    def to_a
      if self.nil_or_empty? then []
      else [@value] end
    end

    # Monad name
    def name
      self.class.name.split('::')[-1]
    end

    # Basic string representation
    def to_s
      "#{self.name}(#{@value})"
    end

    protected

    # Perform internal check on bind
    def _bind(f)
      (self.nil_or_empty? ? @value : f.call(@value))
    end

    # Attempt to call any? on other
    def try_any?(other)
      other.respond_to?(:any?) && other.any?
    end

    # Attempt to call empty? on other
    def try_empty?(other)
      other.respond_to?(:empty?) && other.empty?
    end

    # Is the other (otherwise self) nil or empty?
    def nil_or_empty?(other = nil)
      other ||= self
      other.nil? || self.try_empty?(other)
    end
  end
end
