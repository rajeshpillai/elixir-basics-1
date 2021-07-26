# Only one branch
defmodule Demo do 
  def run do 
    val = 5
    # if val == 5, do: "positive", else: "negative"
    if val == 5 do 
      "positive" 
    else 
      "negative"
    end
  end

  def run1 do 
    val = 5
    if false, do: "positive", else: "negative"
  end

  def run2 do 
    val = 5
    if nil, do: "positive", else: "negative"
  end
end

Demo.run |> IO.inspect
Demo.run1 |> IO.inspect
Demo.run2 |> IO.inspect