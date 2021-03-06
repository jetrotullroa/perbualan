# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :perbualan,
  ecto_repos: [Perbualan.Repo]

# Configures the endpoint
config :perbualan, PerbualanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1PFjBgnQHfIc+KSkyZH3C22y6JpSQxjNz/rKLCX1jt84Msy1c/iZdkPygJjE9x19",
  render_errors: [view: PerbualanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Perbualan.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Live View Config
config :perbualan, PerbualanWeb.Endpoint,
  live_view: [
    signing_salt: "b1dK11/rO3+rxVGEQFr6OnKUX0uURpCl"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
