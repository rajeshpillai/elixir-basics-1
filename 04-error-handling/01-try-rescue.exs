defmodule Demo do 
  def run do 
    try do 
      # Keyword.fetch!([], :a)
      Keyword.fetch!([a: 10], :a)
    rescue
      # e in KeyError -> e
      # Log this error for finding root cause and analysis
      KeyError -> IO.puts("Key not found!!!")
      ArgumentError -> "..."
    after    # finally, ensure
      IO.puts "I will always run no matter what!!"

    else  
      # Executed only if there are no errors and also
      # the value returned in try is available here

      10 -> "Found 10"
      _ -> "Not sure what's that"

    end
  end
end

Demo.run |> IO.inspect