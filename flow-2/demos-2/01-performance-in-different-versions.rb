# Add simple time benchmark
# Между какими версиями произошёл скачок производительности?
require 'benchmark'

ROWS = 100_000
COLS = 10
REPS = 1000

puts "Start"

data = Array.new(ROWS) do
  Array.new(COLS) { "x" * REPS }
end

require 'memory_profiler'

csv = ''

report = MemoryProfiler.report do
  data.each do |row|
    csv << row << ','
  end.join("\n")
end
report.pretty_print(scale_bytes: true)
