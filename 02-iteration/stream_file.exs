defmodule Typewriter do 
  def print_file (filename) do 
    File.stream!(filename) 
     |> Stream.map(&(String.replace(&1, "\n", ""))) 
     |> Enum.each(&Typewriter.print_line/1)
  end

  def print_line(line) do 
    line 
      |> String.split("") 
      |> Enum.each(&Typewriter.print_char/1)

    IO.write "\n"
    :timer.sleep 500
  end

  def print_char(char) do 
    char 
      |> IO.write
    :timer.sleep 100
  end
end


# Typewriter.print_file("spiderman.txt")
Typewriter.print_file("tail_call.exs")

