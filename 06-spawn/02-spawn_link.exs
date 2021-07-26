defmodule  Demo do

  def work do 
    IO.puts "Doing some work..."
    exit :error   # Simulate error
    # exit :normal

  end

  def run do 
    # Establish a relation between the processes
    spawn_link fn -> work() end
    IO.puts "Doing something else..."
  end

  # Traps the exit
  def run2 do 
    Process.flag :trap_exit, true
    spawn_link fn -> work() end

    receive do 
      response -> IO.inspect response
    end

    IO.puts "Doing something else..."
  end
  
end

# Demo.run
Demo.run2 
