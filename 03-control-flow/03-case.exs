defmodule Demo do
  def run(argv) do 
    # IO.puts argv
    parsed_args = OptionParser.parse(argv, switches: [debug: :boolean])
    IO.inspect parsed_args

    case Keyword.fetch(elem(parsed_args, 0), :debug) do 
      {:ok, true} -> "debug!"
      {:ok, false} -> "no debug!!"
      _ -> "debug option is not set!"
    end
  end
end


Demo.run(System.argv) |> IO.inspect

