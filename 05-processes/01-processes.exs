# Every process has unique ID: PID
defmodule Demo do 
  def work() do 
    # Long running method
    :timer.sleep(5000)
    IO.puts "I am done: #{:rand.normal()}"
  end

  def run() do 
    # spawn returns PID immediately
    spawn fn ->
      work()
    end
  end
end

# pid = Demo.run()

# Alternate way to spawn a process
pid = spawn Demo, :run, []

pid |> IO.inspect
IO.puts "Doing some other stuff..."



