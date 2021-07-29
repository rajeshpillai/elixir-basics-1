defmodule TodoappWeb.CommentView do
  use TodoappWeb, :view
  alias TodoappWeb.{CommentView}

  # def render("show.json", %{comment: comment}) do
  #   %{data: render_one(comment, CommentView, "comment.json")}
  # end

  def render("comments.json", %{comments: comments}) do
    %{
      comments: render_many(comments, CommentView, "comment.json")
    }
  end
  
  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      title: comment.title
    }
  end
end
