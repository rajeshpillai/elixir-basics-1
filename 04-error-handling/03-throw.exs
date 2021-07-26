defmodule Demo do 
  def run do 
    try do 
      throw "error1"
    catch 
      "error1" -> "Caught you!!"
      _ -> "Not sure, and not expecting.."
    end
  end
end

Demo.run |> IO.inspect