defmodule AttendanceOrganizer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AttendanceOrganizerWeb.Telemetry,
      AttendanceOrganizer.Repo,
      {DNSCluster, query: Application.get_env(:attendance_organizer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AttendanceOrganizer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AttendanceOrganizer.Finch},
      # Start a worker by calling: AttendanceOrganizer.Worker.start_link(arg)
      # {AttendanceOrganizer.Worker, arg},
      # Start to serve requests, typically the last entry
      AttendanceOrganizerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AttendanceOrganizer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AttendanceOrganizerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
