# In the above module, we have two functions:

# 'tell' sends a message to a receiver using send. 
# 'send' takes a pid and a message - usually a tuple
# 'listen' should recursively calls receive, which is a blocking 
# operation that waits for a message to the current 
# process’ pid and executes some code in response

# Usage:
# $ iex <filename>
# iex> raj = spawn(Person, :listen, [])
# [#PID<0.78.0>] is listening
# #PID<0.78.0>
# iex(3)> Person.tell(raj, "Hello Raj")
# [#PID<0.57.0>] Sending Hello Raj to #PID<0.78.0>
# [#PID<0.78.0>] Received Hello Raj from #PID<0.57.0>
# [#PID<0.78.0>] is listening
# {:ok, #PID<0.57.0>, "Hello Raj"}


defmodule Person do
  def tell(receiver, message) do
    IO.puts "[#{inspect self()}] Sending #{message} to #{inspect receiver}"
    send receiver, {:ok, self(), message}
  end
  
  def listen do
    IO.puts "[#{inspect self()}] is listening"
    receive do
      {:ok, sender, message} ->
        IO.puts "[#{inspect self()}] Received #{message} from #{inspect sender}"
    end
    listen() # long running
  end
end