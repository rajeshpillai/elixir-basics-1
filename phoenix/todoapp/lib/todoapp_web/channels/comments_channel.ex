defmodule TodoappWeb.CommentsChannel do 
  use Phoenix.Channel 

  alias Todoapp.TodoApp.Todo
  alias Todoapp.Repo
  alias Todoapp.DataContext.Comment

  def join("comments:" <> topic_id, _params, socket) do
    IO.puts("+++++")
    IO.puts(topic_id)

    todo = Repo.get(Todo, topic_id) |> Repo.preload([:comments])
    IO.inspect todo 
    result = %{
      id: todo.id,
      title: todo.title
    }
    {:ok, %{todo: todo}, assign(socket, :todo, todo)}
  end
  

  def handle_in(name, %{"title" => title}, socket) do 
    todo = socket.assigns.todo

    changeset = todo 
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{title: title})

    case Repo.insert(changeset) do 
      {:ok, comment} ->
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}

    end

    IO.puts("handle_in ++++++++")
    IO.puts(name)
    IO.inspect(title)

    {:reply, :ok, socket}
  end

end