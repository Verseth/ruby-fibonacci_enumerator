# frozen_string_literal: true

require 'test_helper'

class FibonacciEnumeratorTest < Minitest::Test
  should 'have a version number' do
    refute_nil FibonacciEnumerator::VERSION
  end

  context 'class methods' do
    context 'at' do
      should 'correctly calculate elements' do
        assert_equal 1,  FibonacciEnumerator.at(1)
        assert_equal 1,  FibonacciEnumerator.at(2)
        assert_equal 2,  FibonacciEnumerator.at(3)
        assert_equal 3,  FibonacciEnumerator.at(4)
        assert_equal 5,  FibonacciEnumerator.at(5)
        assert_equal 8,  FibonacciEnumerator.at(6)
        assert_equal 13, FibonacciEnumerator.at(7)
        assert_equal 21, FibonacciEnumerator.at(8)
        assert_equal 34, FibonacciEnumerator.at(9)
        assert_equal 55, FibonacciEnumerator.at(10)
      end

      should 'work correctly with a range' do
        assert_equal [3, 5, 8, 13], FibonacciEnumerator.at(4..7)
      end
    end

    context 'each' do
      should 'return an enumerator when no block is given' do
        assert FibonacciEnumerator.each.is_a?(Enumerator)
        assert_equal [[0, 0], [1, 1], [1, 2], [2, 3]], FibonacciEnumerator.each.with_index.first(4)
      end

      should 'iterate with the given block' do
        result = []

        FibonacciEnumerator.each do |n|
          break if n > 20

          result << n
        end

        assert_equal [0, 1, 1, 2, 3, 5, 8, 13], result
      end
    end

    should 'be enumerable' do
      assert_equal %w[0 1 1 2 3 5 8 13], FibonacciEnumerator.lazy.map(&:to_s).first(8)
      assert FibonacciEnumerator.singleton_class.include?(Enumerable)
    end

  end

  context 'instance methods' do
    context 'at' do
      should 'correctly calculate elements' do
        fib = FibonacciEnumerator.new
        assert_equal 1,  fib.at(1)
        assert_equal 1,  fib.at(2)
        assert_equal 2,  fib.at(3)
        assert_equal 3,  fib.at(4)
        assert_equal 5,  fib.at(5)
        assert_equal 8,  fib.at(6)
        assert_equal 13, fib.at(7)
        assert_equal 21, fib.at(8)
        assert_equal 34, fib.at(9)
        assert_equal 55, fib.at(10)
      end

      should 'work correctly with a range' do
        assert_equal [3, 5, 8, 13], FibonacciEnumerator.new.at(4..7)
      end
    end

    context 'each' do
      should 'return an enumerator when no block is given' do
        assert FibonacciEnumerator.new.each.is_a?(Enumerator)
        assert_equal [[0, 0], [1, 1], [1, 2], [2, 3]], FibonacciEnumerator.new.each.with_index.first(4)
      end

      should 'iterate with the given block' do
        result = []

        FibonacciEnumerator.new.each do |n|
          break if n > 20

          result << n
        end

        assert_equal [0, 1, 1, 2, 3, 5, 8, 13], result
      end
    end

    should 'be enumerable' do
      assert_equal %w[0 1 1 2 3 5 8 13], FibonacciEnumerator.new.lazy.map(&:to_s).first(8)
      assert FibonacciEnumerator.include?(Enumerable)
    end

  end

end
