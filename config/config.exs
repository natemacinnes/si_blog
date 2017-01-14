# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :si_blog,
  ecto_repos: [SiBlog.Repo]

# Configures the endpoint
config :si_blog, SiBlog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2dAi03Gvbvv6u8+A4nmW6SL4N0/Cxd1a6hMCbmbXBO+DDvIncgFSsk0Gt3dci0+8",
  render_errors: [view: SiBlog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SiBlog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
