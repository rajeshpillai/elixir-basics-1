defmodule TodoappWeb.TodoController do
  use TodoappWeb, :controller

  alias Todoapp.TodoApp
  alias Todoapp.TodoApp.Todo
  alias Todoapp.Repo

  import Ecto.Query, only: [from: 2, from: 1]
  alias Todoapp.DataContext.Comment

  import Todoapp.Plugs.CountTodos  #function plug
  
  alias Todoapp.Plugs.CountTodosModule  # module plug

  plug :todos_count when action in [:index]
  
  plug CountTodosModule, [msg: "Your total # of todos: "]  # when action in [:index]

  def index(conn, _params) do
    # todos = TodoApp.list_todos()
    # todos = Repo.all(Todo) |> Repo.preload(:comments)
    # todos = Repo.all(from(p in Todo, preload: [:comments], select: p))

    # query = from t in Todo,
    #       left_join: c in Comment, on: c.todo_id == t.id
    # todos = Repo.all(query)
    
    # Grab parent/child record in one query, use preload in combination 
    # with join (Only for demo code. Use it at the right place)
    
    # TODO:
    query = from t in Todo,
      left_join: c in assoc(t, :comments),
      preload: [comments: c]

    todos = Repo.all(query)

    render(conn, :index, todos: todos)
  end

  # Json route
  def todo_json(conn, _params) do
    todos = TodoApp.list_todos()
        |> Enum.map(&todo_json/1)
  
    json(conn, todos)
  end

  defp todo_json(todo) do
    %{
      title: todo.title,
      inserted_at: todo.inserted_at,
      updated_at: todo.updated_at
    }
  end

  def new(conn, _params) do
    changeset = TodoApp.change_todo(%Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    case TodoApp.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
     
    
    # TRY IN ONE QUERY
      ##  - Two different approaches

    # Approach 1
    # one_todo = Repo.get(Todo, id)
    # comments = Ecto.assoc(one_todo, :comments) |> Repo.all
    # render(conn, "show.html", todo: one_todo, comments: comments)

    # Approach 2
    # todo = Repo.get(Todo, id) |> Repo.preload([:comments])
    # render(conn, "show.html", todo: todo )

    # Approach 3
    query = from t in Todo,
          where: t.id == ^id,
          left_join: c in assoc(t, :comments),
          preload: [comments: c]
   
    todo = Repo.one(query)

    # text(conn, "hello query")

    render(conn, :show, todo: todo )
  end

  def edit(conn, %{"id" => id}) do
    todo = TodoApp.get_todo!(id)
    changeset = TodoApp.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = TodoApp.get_todo!(id)

    case TodoApp.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = TodoApp.get_todo!(id)
    {:ok, _todo} = TodoApp.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
