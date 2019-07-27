require 'ruby-progressbar'

count = 100

progressbar = ProgressBar.create(
  total: count,
  format: '%a, %J, %E %B' # elapsed time, percent complete, estimate, bar
  # output: File.open(File::NULL, 'w') # IN TEST ENV
)

(1..count).each do |i|
  sleep(1)
  progressbar.increment
end
