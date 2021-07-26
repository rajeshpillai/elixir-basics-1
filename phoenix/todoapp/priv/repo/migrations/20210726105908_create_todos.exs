defmodule Todoapp.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :completed, :boolean, default: false, null: false
      add :priority, :string

      timestamps()
    end

  end
end
