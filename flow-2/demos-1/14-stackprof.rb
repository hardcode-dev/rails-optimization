# Stackprof report
# ruby 14-stackprof.rb
# cd stackprof_reports
# stackprof stackprof.dump
# stackprof stackprof.dump --method Object#work
require 'stackprof'
require_relative 'work_method.rb'

StackProf.run(mode: :wall, out: 'stackprof_reports/stackprof.dump', interval: 1000) do
  work('small.txt', disable_gc: true)
end
