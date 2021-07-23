# tail_call -> the last statement in the funciton should be 
# the function call and nothing else
defmodule Calc do 
  # Factorial
  def fact(n), do: do_fact(1, n)
  
  defp do_fact(result, 0) do
     result
  end

  defp do_fact(result, n) do 
    result = result * n 
    do_fact(result, n-1)
    # result * n
    #   |> do_fact (n - 1)
  end

end


# Calc.fact(5) |> IO.puts
Calc.fact(100000) |> IO.puts
# Calc.fact(10_00_000) |> IO.puts

