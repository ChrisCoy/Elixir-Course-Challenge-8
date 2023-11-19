# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :coyapi,
  ecto_repos: [Coyapi.Repo],
  generators: [timestamp_type: :utc_datetime]

config :coyapi, Coyapi.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :tesla, adapter: Tesla.Adapter.Hackney

config :coyapi, CoyapiWeb.Auth.Guardian,
  issuer: "coyapi",
  secret_key: "L3VUYZ4EUeti77fz469ynWXBTKqp3wrMSoTz+PWNLXfqH4RMZmLQJGi4FNV9NWCH"

config :coyapi, CoyapiWeb.Auth.Pipeline,
  module: CoyapiWeb.Auth.Guardian,
  error_handler: CoyapiWeb.Auth.ErrorHandler

# Configures the endpoint
config :coyapi, CoyapiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: CoyapiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Coyapi.PubSub,
  live_view: [signing_salt: "CyO+Z5wS"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :coyapi, Coyapi.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
