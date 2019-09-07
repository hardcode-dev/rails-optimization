```ruby
# in boot.rb
# Uncomment to benchmark gem loading time
# require "benchmark"
# def require(file_name)
#   result = nil

#   time = Benchmark.realtime do
#     result = super
#   end

#   if time > 0.1
#     puts "#{time} #{file_name}"
#   end

#   result
# end
```
