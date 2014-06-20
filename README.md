# Categoric

Adds some monadic flavor to Ruby for fun and profit.

NOTE: Still an early work in progress.

## Usage

```ruby
require 'categoric'

Maybe(42) == Just(42)
Maybe(nil) == Nothing

Maybe(42).map { |n| n * 2 } == Just(84)
Maybe(nil).map { |n| n * 2 } == Nothing

Try(->{ 1 + 1 }) == Success(2)
Try(->{ 1 + nil }) == Failure(TypeError("nil can't be coerced into Fixnum"))

Try(->{ 1 + 1 }).map { |n| n + 1 } == Success(3)
Try(->{ 1 + nil }) == Failure

p = ->(n) { n > 0 : :right : :left }
Either(p, 42) == Right(42)
Either(p, -7) == Left(-7)
Either(p) { 123 } == Right(123)
Either(p) { -10 } == Left(-10)
```

## License

Copyright &copy; 2014 Derek Schaefer (<derek.schaefer@gmail.com>)

Licensed under the [MIT License](http://opensource.org/licenses/MIT).
