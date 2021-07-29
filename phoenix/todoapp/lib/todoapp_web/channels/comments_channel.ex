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
  

  def handle_in(name, %{"content" => content}, socket) do 
    todo = socket.assigns.todo

    changeset = todo 
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(%{title: content})

    case Repo.insert(changeset) do 
      {:ok, comment} ->
        # broadcast to every client
        broadcast!(socket, 
          "comments:#{socket.assigns.todo.id}:new", 
          %{comment: comment
        })

        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}

    end

    IO.puts("handle_in ++++++++")
    IO.puts(name)
    IO.inspect(content)

    {:reply, :ok, socket}
  end

end