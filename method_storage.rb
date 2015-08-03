class Foo
  def bar(arg, &block)
    block.call arg
  end
end

foo = Foo.new
foo.bar(10) { |e| e + 5 } #=> 15

FOO = foo.method(:bar).to_proc.call

foo.class.send(:define_method, :bar) { |arg| "this is a stubbed method" }

foo.bar(10) { |e| e + 5 } #=> "this is a stubbed method"

foo.class.send(:define_method, :bar) { |arg| FOO }

foo.bar(10) { |e| e + 5 } #=> 15


