# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fitfam,
  namespace: FitFam,
  ecto_repos: [FitFam.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :fitfam, FitFamWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5Joiat27YOKQqAgR4WhhrPTWlyh39O80ApVDHmUSnFXQmQ5FPYzS20BletnrmZXp",
  render_errors: [view: FitFamWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: FitFam.PubSub,
  live_view: [signing_salt: "0zgVL2cx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, [default_scope: "email, public_profile"]}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

config :fitfam, FitFam.Guardian,
  issuer: "FitFam",
  secret_key: System.get_env("GUARDIAN_SECRET")

config :fitfam, FitFam.Mailer,
  adapter: Swoosh.Adapters.Postmark,
  api_key: System.get_env("POSTMARK_API_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
