class Calculator
  operators = {:+ => "add", :- => "subtract", :* => "multiply", :/ => "divide", :% => "modulo"}

  operators.each do |sym, str|
    define_method("#{str}") do |*tuple|
      sym.to_proc.call(*tuple)
    end
  end
end

c = Calculator.new
c.add 10, 2
c.subtract 10, 2
c.multiply 10, 2
c.divide 10, 2
c.modulo 7, 3


# uglified, just for fun:
# class Calculator
#   operators = {:+ => "add", :- => "subtract", :* => "multiply", :/ => "divide", :% => "modulo"}
#   operators.each {|s,w| define_method("#{w}") {|*a| s.to_proc.call(*a)}}
# end
