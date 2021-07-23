# defmodule Streams do
#   def transform do
#     [1,2,3,4,5,6] 
#       |> Enum.map(fn (n) -> n * 2 end )
#       |> Enum.drop_every(3)
#       |> Enum.reduce(0, fn (c,p) -> c + p end )
#   end
# end

# defmodule Streams do
#   def transform do
#     [1,2,3,4,5,6] 
#       |> Enum.map(&(&1 * 2))
#       |> Enum.drop_every(3)
#       |> Enum.reduce(0, &(&1 + &2))
#   end
# end

defmodule Streams do
  def transform do
    [1,2,3,4,5,6] 
      |> Stream.map(&(&1 * 2))
      |> Stream.drop_every(3)
      |> Enum.reduce(0, &(&1 + &2))
  end

  def own_stream(multiplier) do 
    Stream.iterate(1, &(&1 * multiplier))

    # multiplier = 2
    # 1 * 2 = 2
    # 2 * 2 = 4
    # 4 * 2 = 8
  end
end


# Streams.transform |> IO.inspect
Streams.own_stream(2)
  |> Enum.take(15)
  |> IO.inspect








