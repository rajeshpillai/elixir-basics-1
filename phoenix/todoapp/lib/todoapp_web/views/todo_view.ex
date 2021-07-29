defmodule TodoappWeb.TodoView do
  use TodoappWeb, :view
  alias TodoappWeb.{TodoView, CommentView}

  def render("index.json", %{todos: todos}) do 
    %{
      todos: render_many(todos, TodoView, "todo.json")
    }
  end

  def render("show.json", %{todo: todo}) do 
    %{
      todo: render_one(todo, TodoView, "todo_with_comments.json")
    }
  end

  def render("todo_with_comments.json", %{todo: todo}) do 
    %{
      id: todo.id, 
      title: todo.title,
      completed: todo.completed,
      comments: render_many(todo.comments, CommentView, "comment.json")
    }
  end


  def render("todo.json", %{todo: todo}) do 
    %{
      id: todo.id,
      title: todo.title,
      completed: todo.completed
    }
  end
  
end
