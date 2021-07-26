# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todoapp,
  ecto_repos: [Todoapp.Repo]

# Configures the endpoint
config :todoapp, TodoappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gnW9v35w4ZdlWYC2eNX6qDtecP+6XzYDC/DEf0CII/iKPBCfenVzCjfv3xeNuRVx",
  render_errors: [view: TodoappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Todoapp.PubSub,
  live_view: [signing_salt: "f2YVUQTN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
