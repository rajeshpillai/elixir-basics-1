defmodule Todoapp.DataContext.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:title, :id]}
  schema "comments" do
    field :title, :string
    # field :todo_id, :id
    belongs_to :todos, Todo, foreign_key: :todo_id
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:title, :todo_id])
    |> validate_required([:title])
  end
end
