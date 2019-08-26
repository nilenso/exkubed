defmodule Exkubed.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # LibCluster Topologies
    topologies = [
      example: [
        strategy: Cluster.Strategy.Kubernetes,
        config: [
          mode: :ip,
          kubernetes_node_basename: "exkubed",
          kubernetes_selector: "app=x-cubed",
          kubernetes_namespace: "default",
          polling_interval: 10_000
        ]
      ]
    ]

    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      ExkubedWeb.Endpoint,
      # Starts a worker by calling: Exkubed.Worker.start_link(arg)
      # {Exkubed.Worker, arg},

      # Cluster supervisor for Libcluster
      {Cluster.Supervisor, [topologies, [name: Exkubed.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exkubed.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExkubedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
