defmodule Todoapp.Repo do
  use Ecto.Repo,
    otp_app: :todoapp,
    adapter: Ecto.Adapters.Postgres
end
