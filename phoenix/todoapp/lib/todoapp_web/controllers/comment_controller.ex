defmodule TodoappWeb.CommentController do
  use TodoappWeb, :controller

  alias Todoapp.DataContext
  alias Todoapp.DataContext.Comment
  alias Todoapp.TodoApp

  def index(conn, _params) do
    comments = DataContext.list_comments()
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = DataContext.change_comment(%Comment{})
    
    # Get the todos
    todos = TodoApp.list_todos() 
      |> Enum.map(&{"#{&1.title}", &1.id})

    render(conn, "new.html", changeset: changeset, todos: todos)
  end

  def create(conn, %{"comment" => comment_params}) do
    case DataContext.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        # Get the todos
        todos = TodoApp.list_todos() 
          |> Enum.map(&{"#{&1.title}", &1.id})
        render(conn, "new.html", changeset: changeset, todos: todos)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = DataContext.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = DataContext.get_comment!(id)
    todos = TodoApp.list_todos() 
      |> Enum.map(&{"#{&1.title}", &1.id})
    changeset = DataContext.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset, todos: todos)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = DataContext.get_comment!(id)

    case DataContext.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: Routes.comment_path(conn, :show, comment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = DataContext.get_comment!(id)
    {:ok, _comment} = DataContext.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: Routes.comment_path(conn, :index))
  end
end
