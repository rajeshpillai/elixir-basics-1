defmodule Todoapp.Plugs do
  import Plug.Conn 
  import Ecto.Query, only: [from: 2]

  alias Todoapp.TodoApp.Todo
  alias Todoapp.Repo


  def todos_count(conn, _opts) do 
    IO.puts("plug +++++++ plug")
    total = Repo.one(from t in Todo, select: count("*"))
    assign(conn, :todos_count, total)
  end
end