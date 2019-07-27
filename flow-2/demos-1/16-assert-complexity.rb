# https://github.com/seattlerb/minitest/blob/master/lib/minitest/benchmark.rb
# assert_performance_constant
# assert_performance_exponential
# assert_performance_power
# assert_performance_logarithmic
# assert_performance_linear

require 'minitest/autorun'
require 'minitest/benchmark'

GC.disable

class BenchTest < MiniTest::Benchmark
  # def self.bench_range
  #   [1000, 10000, 100000]
  # end

  def bench_algorithm
    assert_performance_linear do |n|
      algorithm(n)
    end
  end

  def algorithm(n)
    arr = []
    1.upto(n) { |i| arr << i }
    arr.sum
  end
end
