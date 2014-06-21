# Categoric [![Build Status](https://secure.travis-ci.org/derek-schaefer/ruby-categoric.png?branch=master)](http://travis-ci.org/derek-schaefer/ruby-categoric)

Add some monadic flavor to Ruby for fun and profit.

NOTE: Still an early work in progress.

## Usage

```ruby
require 'categoric'

Maybe(42) == Just(42)
Maybe(nil) == Nothing()

Maybe(42)._ == 42
Maybe(nil)._ == nil

Maybe(42) >> ->(n) { n * 2 } == Just(84)
Maybe(nil) >> ->(n) { n * 2 } == Nothing()

Maybe(42) * 2 + 1 == Just(85)
Maybe(nil) * 2 + 1 == Nothing()

Try(->{ 1 + 1 }) == Success(2)
Try(->{ 1 + nil }) == Failure(TypeError.new)

Try(->{ 1 + 1 })._ == 2
Try(->{ 1 + nil })._ == TypeError.new

Try(->{ 1 + 1 }) >> ->(n) { n + 1 } == Success(3)
Try(->{ 1 + nil }) >> ->(n) { n + 1 } == Failure(TypeError.new)

Try(->{ 1 + 1 }) * 2 + 1 == Success(5)
Try(->{ 1 + nil }) * 2 + 1 == Failure(TypeError.new)

p = ->(n) { n > 0 }
Either(p, 42) == Right(42)
Either(p, -7) == Left(-7)
Either(p) { 123 } == Right(123)
Either(p) { -10 } == Left(-10)
```

## License

Copyright &copy; 2014 Derek Schaefer (<derek.schaefer@gmail.com>)

Licensed under the [MIT License](http://opensource.org/licenses/MIT).
