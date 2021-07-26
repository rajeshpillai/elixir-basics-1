# Processes can exit.  (We can track them)
defmodule Demo do 
  def run do 
    try do 
      # exit :normal  # normal exit
      # exit :very_bad
      exit :idontknow

    catch 
      :exit, :very_bad -> "Exited as something is not right!!"
      :exit, _ -> "Something very very bad happened"
    end

  end
end

Demo.run |> IO.inspect