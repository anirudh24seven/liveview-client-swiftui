defmodule LvnTutorial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LvnTutorialWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LvnTutorial.PubSub},
      # Start the Endpoint (http/https)
      LvnTutorialWeb.Endpoint,
      # Start a worker by calling: LvnTutorial.Worker.start_link(arg)
      # {LvnTutorial.Worker, arg}
      LvnTutorial.FavoritesStore
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LvnTutorial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LvnTutorialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
