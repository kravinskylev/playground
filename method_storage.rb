class Foo
  def bar(arg, &block)
    block.call(arg)     # => 15, 15
  end
end

foo = Foo.new              # => #<Foo:0x007fc9038361b0>
foo.bar(10) { |e| e + 5 }  # => 15

FOO = foo.method(:bar).to_proc  # => #<Proc:0x007fc903835cb0 (lambda)>

foo.class.send(:define_method, :bar) { |arg| "this is a stubbed method" }  # => :bar

foo.bar(10) { |e| e + 5 }  # => "this is a stubbed method"

foo.class.send(:define_method, :bar) { |arg, &block| FOO.call(arg, &block) }  # => :bar

foo.bar(10) { |e| e + 5 }  # => 15
