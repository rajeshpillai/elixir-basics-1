defmodule TodoappWeb.CommentsChannel do 
  use Phoenix.Channel 

  def join(name, _message, socket) do
    IO.puts("+++++")
    IO.puts(name)
    {:ok, %{hey: "there"}, socket}
  end
  
  def join("comments:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in(name, message, socket) do 
    IO.puts("handle_in ++++++++")
    IO.puts(name)
    IO.inspect(message)

    {:reply, :ok, socket}
  end

end