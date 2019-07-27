# RubyProf CallStack report
# ruby 12-ruby-prof-callstack.rb
# open ruby_prof_reports/callstack.txt
require 'ruby-prof'
require_relative 'work_method.rb'

RubyProf.measure_mode = RubyProf::WALL_TIME

result = RubyProf.profile do
  work('small.txt', disable_gc: true)
end

printer = RubyProf::CallStackPrinter.new(result)
printer.print(File.open('ruby_prof_reports/callstack.html', 'w+'))
