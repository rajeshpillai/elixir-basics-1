# Stateful: Long running process.  Should be able to handle messages and also state/data if needed
defmodule  MyGenServer do
  def start do
    initial_state = []
    receive_messages(initial_state)
  end  

  def receive_messages(state) do 
    receive do 
      msg ->
        {:ok, new_state} = handle_message(msg, state)
        receive_messages(new_state)
    end
  end

  # api
  def handle_message({:store, value}, state) do 
    {:ok, [value | state]}
  end

  def handle_message({:send_all_values, pid}, state) do 
    send(pid, {:all_values, state})
    {:ok, state}
  end

end

