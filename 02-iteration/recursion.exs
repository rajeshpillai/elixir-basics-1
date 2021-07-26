# function fact(n) {
#   if (n == 0) return 1;
#   return n * fact(n - 1);  
# }

# iex -r recursion.exs   # for debugging
defmodule Calc do 
  # Factorial
  def fact(0), do: 1
  # def fact(n), do: n * fact(n-1)
  def fact(n) do 
    require IEx; IEx.pry
    n * fact(n-1)
  end

  # Multiply
  def mult([]), do: 1

  def mult([head | tail]) do 
    head * mult(tail)
  end
end


# Calc.fact(100000) |> IO.puts

Calc.fact(5) |> IO.puts

# Calc.fact(10_00_000) |> IO.puts

# Calc.mult([]) |> IO.puts  # 1
# Calc.mult([1,2,3]) |> IO.puts  # 6
