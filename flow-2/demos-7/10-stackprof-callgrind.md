```bash
stackprof tmp/test_prof/stack-prof-report-wall-raw-total.dump --callgrind >> callgrind.cgd
qcachegrind callgrind.cgd
```

https://github.com/bblimke/webmock/commit/1cc36e5d9a64f081cf83683752ceea6f04bf4ff5
```ruby
class WebMockNetBufferedIO < BufferedIO
  def initialize(io, read_timeout: 60, continue_timeout: nil, debug_output: nil)
    @read_timeout = read_timeout
    @rbuf = ''.dup
    @debug_output = debug_output
    @io = case io
    when Socket, OpenSSL::SSL::SSLSocket, IO
      io
    when StringIO
      PatchedStringIO.new(io.string)
    when String
      PatchedStringIO.new(io)
    end
    raise "Unable to create local socket" unless @io
  end

  if RUBY_VERSION >= '2.6.0'
    def rbuf_fill
      trace = TracePoint.trace(:line) do |tp|
        if tp.binding.local_variable_defined?(:tmp)
          tp.binding.local_variable_set(:tmp, nil)
        end
      end

      super

      trace.disable
    end
  end
end
```

## оптимизация
Уберём блок с if RUBY_VERSION в нашей версии гема.

WebMockNetBufferedIO выпал из топа, стало побыстрее

Теперь его BacktraceClean вызывает HoneyComb!

Убираем HoneyComb ----> Полностью выбили BacktraceCleaner из топа
