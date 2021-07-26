defmodule Todoapp.TodoApp.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :completed, :boolean, default: false
    field :priority, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :completed, :priority])
    |> validate_required([:title, :completed, :priority])
  end
end
