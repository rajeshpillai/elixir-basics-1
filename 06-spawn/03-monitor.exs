# Uni directional
defmodule  Demo  do
  def work do
    IO.puts "doing work..."
    exit :error  # Even though we are abnormally exiting,the run() process will not die
  end

  def run do 
    # Process.monitor pid
    spawn_monitor(Demo, :work, [])
    
    receive do 
      msg -> IO.inspect msg
    end

  end
end

Demo.run 
