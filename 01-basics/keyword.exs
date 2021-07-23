defmodule Canvas do

  @defaults [fg: "black", bg: "white", font: "sans-serif"]
  
  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Options:     #{inspect(options)}"
  end
end

Canvas.draw_text("Hello keyword list", fg: "red", style: "italic")
