defmodule Todoapp.Plugs.CountTodosModule do
  import Plug.Conn 
  import Ecto.Query, only: [from: 2]

  alias Todoapp.TodoApp.Todo
  alias Todoapp.Repo

  def init(opts) do 
    Keyword.fetch(opts, :msg)
  end

  def call(conn, msg) do 
    IO.puts("module plug +++++++ plug")
    total = Repo.one(from t in Todo, select: count("*"))

    case msg do
      {:ok, msg} ->
        message = "#{msg} #{total}"
        assign(conn, :todo_count_message, message)

      :error ->
        message = "We found #{total} todos"
        assign(conn, :todo_count_message, message)
    end
  end

  # def call(conn, _opts) do 
  #   IO.puts("module plug +++++++ plug")
  #   total = Repo.one(from t in Todo, select: count("*"))
  #   assign(conn, :mtodos_count, total)
  # end


end