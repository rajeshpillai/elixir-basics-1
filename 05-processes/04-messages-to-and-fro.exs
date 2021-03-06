defmodule Demo do 
  def work do 
    IO.puts "I am busy doing work..."

    # recieve: waits for message to arrive
    # If not message, it waits indefinitely

    result = receive do 
      {sender, {a, b}} -> send(sender, a * b)
      message -> message
    after 5000 -> IO.puts "Enough! I am done"
    end

    IO.inspect result
  end

  def run(message) do 
    pid = spawn fn -> 
      work()
    end
   
    # Send message
    send pid, {self(), message}  # self() PID of current process

    # Read from the mail box (FIFO)
    receive do 
      response ->  
        :timer.sleep(5000)
        IO.puts("Response: #{response}")
    # after 
    #   1000 ->IO.puts "No response received"
    end

    IO.puts "Is this blocked?"
  end
end

# Demo.run("Hello processes!!")
Demo.run({2,3})
