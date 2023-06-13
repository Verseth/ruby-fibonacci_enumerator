# frozen_string_literal: true

require_relative 'fibonacci_enumerator/version'

# An Enumerable class that makes it possible
# to efficiently calculate elements of the Fibonacci sequence.
#
# It is an Enumerable object so it can be iterated through using `each`
# and implements methods like `first`, `select`, `map` etc.
class FibonacciEnumerator
  include ::Enumerable

  class << self
    alias class_include? include?

    include ::Enumerable

    # @param index [Integer, Range]
    def at(index)
      new.at(index)
    end
    alias [] at

    # @return [Enumerator, self]
    # @yieldparam [Integer]
    def each(&block)
      new.each(&block)
    end

    alias include? class_include?
  end

  attr_reader :cache

  def initialize
    reset_cache
  end

  # @param index [Integer, Range]
  # @return [Integer]
  def at(index)
    return at_int(index) if index.is_a?(::Integer)

    at_range(index)
  end

  # @return [Enumerator, self]
  # @yieldparam [Integer]
  def each
    return enum_for(:each) unless block_given?

    (0..).each do |i|
      yield at_int(i)
    end

    self
  end

  # @return [void]
  def reset_cache
    @cache = [0, 1, 1]
  end

  private

  # @param index [Integer]
  # @return [Integer]
  def at_int(index)
    if (item = @cache[index])
      return item
    end

    while index >= @cache.length # rubocop:disable Style/WhileUntilModifier
      @cache[@cache.length] = @cache[@cache.length - 1] + @cache[@cache.length - 2]
    end

    @cache[index]
  end

  # @param range [Range]
  # @return [Integer]
  def at_range(range)
    return @cache[range] if range.end < @cache.length

    while range.end >= @cache.length # rubocop:disable Style/WhileUntilModifier
      @cache[@cache.length] = @cache[@cache.length - 1] + @cache[@cache.length - 2]
    end

    @cache[range]
  end
end
