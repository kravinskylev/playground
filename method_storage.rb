class Foo
  def bar(arg, &block)
    block.call(arg)
  end

  def foobar
    "foobar"
  end
end

class Object
  def stubber(hash)
    hash.each do |name, value|
      if methods.include?(name)
        instance_variable_set("@lobster_#{name}", method(name).to_proc)
      end
      self.send(:define_singleton_method, name) { value }
    end
  end

  def reset
    singleton_methods.each do |method|
      unless instance_variable_get("@lobster_#{method}") == nil
        instance_method = instance_variable_get("@lobster_#{method}")
        send(:define_singleton_method, method) { |*arg, &block| instance_method.call(*arg, &block) }
      else
        self
        method
        self.instance_eval { undef method }
        p "im being evalled"
      end
    end
  end
end

foo = Foo.new
foo.bar(10) { |e| e + 5 }
foo.foobar
foo.stubber(:bar => "new method",
            :foobar => "barfoo",
            :new_method => "new value")
foo.bar
foo.foobar
foo.new_method
foo.reset
foo.bar(10) {|e| e + 5}
foo.foobar
foo.new_method

foo.instance_eval { undef :new_method }
foo.new_method
