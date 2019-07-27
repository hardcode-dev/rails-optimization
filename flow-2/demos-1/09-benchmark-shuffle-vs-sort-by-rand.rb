# gem install kalibera

require 'benchmark/ips'

SIZE = 10_000
ARRAY = [*1..SIZE]

Benchmark.ips do |x|
  x.report('Array#shuffle') do
    ARRAY.shuffle
  end
  x.report('Array#sort_by { rand }') do
    ARRAY.sort_by { rand }
  end
  x.compare!
end
