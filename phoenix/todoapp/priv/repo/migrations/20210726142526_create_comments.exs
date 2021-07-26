defmodule Todoapp.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :title, :string
      add :todo_id, references(:todos, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:todo_id])
  end
end
