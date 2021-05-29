defmodule ExJatl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExJatl.Repo,
      # Start the Telemetry supervisor
      ExJatlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExJatl.PubSub},
      # Start the Endpoint (http/https)
      ExJatlWeb.Endpoint
      # Start a worker by calling: ExJatl.Worker.start_link(arg)
      # {ExJatl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExJatl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExJatlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
