module Categoric
  module Monad
    def initialize(value = nil)
      @value =
        if value.is_a? self.class then other._
        else value end
    end

    # Create a new monad with the value
    def self.from(value)
      self.class.new value
    end

    # Extract the boxed value
    def _
      @value
    end

    # Does the monad contain a value?
    def any?
      false
    end

    # Does the monad contain nothing?
    def empty?
      !self.any?
    end

    # Privileged access to the boxed value
    def bind(proc = nil, &block)
      (proc || block).call self._
    end

    # Map the value to a new monad with the given function
    def map(proc = nil, &block)
      f = (proc || block)
      self.class.from((f.call(@value) unless self.nil_or_empty?))
    end

    # Map the value's contents to a new monad with the given
    # function, while eliminating empty results.
    def fmap(proc = nil, &block)
      f = (proc || block)

      vs =
        if @value.respond_to? :map
          @value.map do |v|
            self.class.from(f.call(v)) unless self.nil_or_empty?(v)
          end
        end

      self.class.from vs
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
      s = ''
      s << self.name
      s << "(#{@value.inspect})" if @value
      s
    end

    protected

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
