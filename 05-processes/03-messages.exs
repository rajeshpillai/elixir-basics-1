defmodule Demo do 
  def work do 
    IO.puts "I am busy doing work..."

    # recieve: waits for message to arrive
    # If not message, it waits indefinitely

    result = receive do 
      {a, b} -> a * b      
      message -> message
    end

    IO.inspect result
  end

  def run(message) do 
    pid = spawn fn -> 
      work()
    end
   
    # Send message
    send pid, message
  end
end

Demo.run("Hello processes!!")
Demo.run({2,3})
