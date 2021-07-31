defmodule Todoapp.Plugs.CountTodosModule do
  import Plug.Conn 
  import Ecto.Query, only: [from: 2]

  alias Todoapp.TodoApp.Todo
  alias Todoapp.Repo

  def init(opts) do 
    opts 
  end

  def call(conn, _opts) do 
    IO.puts("module plug +++++++ plug")
    total = Repo.one(from t in Todo, select: count("*"))
    assign(conn, :mtodos_count, total)
  end
end