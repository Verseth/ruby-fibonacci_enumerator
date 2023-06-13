# FibonacciEnumerator

This gems adds `FibonacciEnumerator`, an Enumerable class that makes it possible
to efficiently calculate elements of the Fibonacci sequence.

It is an Enumerable object so it can be iterated through using `each`
and implements methods like `first`, `select`, `map` etc.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add fibonacci_enumerator

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install fibonacci_enumerator

## Usage

Elements of the Fibonacci sequence are calculated using the dynamic programming approach.
Instances of `FibonacciEnumerator` contain a cache that accumulates already calculated
elements of the sequence.

You can use the `FibonacciEnumerator` class directly as an `Enumerable` object for convenience.

### at

The `at` method aliases as `[]` can be used to get a particular element of the sequence.

```rb
FibonacciEnumerator.at(1) #=> 1
FibonacciEnumerator.at(2) #=> 1
FibonacciEnumerator.at(3) #=> 2
FibonacciEnumerator.at(4) #=> 3
FibonacciEnumerator.at(5) #=> 5
FibonacciEnumerator.at(6) #=> 8

FibonacciEnumerator[1] #=> 1
FibonacciEnumerator[2] #=> 1
FibonacciEnumerator[3] #=> 2
FibonacciEnumerator[4] #=> 3
FibonacciEnumerator[5] #=> 5
FibonacciEnumerator[6] #=> 8
```

You can also pass a `Range`.

```rb
FibonacciEnumerator.at(4..7) #=> [3, 5, 8, 13]
FibonacciEnumerator[4..7] #=> [3, 5, 8, 13]
```

### each

You can iterate through the Fibonacci series.
Keep in mind that it's infinite, so the loop will
go on forever unless manually interrupted

```rb
FibonacciEnumerator.each do |element|
    puts element
end
# 1
# 1
# 2
# 3
# 8
# ...
```

### select

You can filter elements using `select` or `reject`

```rb
FibonacciEnumerator.first(25).select(&:even?)
#=> [0, 2, 8, 34, 144, 610, 2584, 10946, 46368]
```

This class is `Enumerable` so methods like `each`, `select`, `reject`, `take` etc
are available as well.

### Sharing the cache between multiple calculations

When you want to manually get particular elements of the Fibonacci sequence
you can save some time by sharing the cache between calculations.

You can do that by creating an instance of `FibonacciEnumerator`.

```rb
fib = FibonacciEnumerator.new

fib[10]
#=> 55
fib[10] # cache is reused, no calculations were necessary!
#=> 55
fib[15] # the first 10 elements were already calculated, so its faster
#=> 610
```

Instances are also `Enumerable` objects so methods like `each`, `select`, `reject`, `take` etc
are available as well.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Verseth/ruby-fibonacci_enumerator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
