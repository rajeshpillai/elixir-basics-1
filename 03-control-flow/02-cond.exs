# pattern matching (multiple branches)

defmodule Demo do 
  def run(str) do 
    len = String.length(str)
    cond do 
      len > 0 && len < 5 -> "short"
      len >= 5 && len < 10 -> "medium"
      len > 10 -> "long"
      true -> "An empty string..." #fallback clause
    end
  end
end

Demo.run("") |> IO.inspect
Demo.run("h") |> IO.inspect
Demo.run("hello") |> IO.inspect
Demo.run("hello elixir!") |> IO.inspect



