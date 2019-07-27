# Correct result with GIL, incorrect without GIL
puts 'start'

array = []

5.times.map do
  Thread.new do
    1000.times do
      array << nil
    end
  end
end.each(&:join)

puts array.size
