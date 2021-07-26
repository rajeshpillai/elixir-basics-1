defmodule Demo do
  def work do 
    IO.puts "Work process..."
    # exit :normal
    exit :error  # Simulating error
  end

  def run do 
    spawn fn -> work() end 
    IO.puts "Doing something else..."
  end
end

Demo.run