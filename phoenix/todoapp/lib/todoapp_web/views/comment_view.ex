defmodule TodoappWeb.CommentView do
  use TodoappWeb, :view
  alias TodoappWeb.{CommentView}

  # def render("comments.json", %{comments: comments}) do 
  #   :ok
  # end

  def render("comment.json", %{comment: comment}) do 
    %{
      id: comment.id,
      title: comment.title
    }
  end
end
