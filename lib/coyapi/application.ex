defmodule Coyapi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CoyapiWeb.Telemetry,
      Coyapi.Repo,
      {DNSCluster, query: Application.get_env(:coyapi, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Coyapi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Coyapi.Finch},
      # Start a worker by calling: Coyapi.Worker.start_link(arg)
      # {Coyapi.Worker, arg},
      # Start to serve requests, typically the last entry
      CoyapiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Coyapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CoyapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
