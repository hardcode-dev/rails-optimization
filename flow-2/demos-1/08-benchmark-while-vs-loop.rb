# gem install kalibera
require 'benchmark/ips'

SIZE = 100_000

Benchmark.ips do |x|
  # The default is :stats => :sd, which doesn't have a configurable confidence
  # confidence is 95% by default, so it can be omitted
  x.config(:stats => :bootstrap, :confidence => 99)

  x.report("while") do
    i = 0
    a = []
    while i <= SIZE
      i += 1
      a << i
    end
  end

  x.report("loop") do
    i = 0
    a = []
    loop do
      break if i == SIZE
      i += 1
      a << i
    end
  end

  x.compare!
end
