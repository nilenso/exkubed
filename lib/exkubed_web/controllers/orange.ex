defmodule ExkubedWeb.Controllers.Orange do
  use ExkubedWeb, :controller

  def peel(conn, _params) do
    json(conn, %{message: "Peeling an orange for you! #{inspect(self())}"})
  end

  def bag(conn, _params) do
    json(conn, %{message: "Bag of orange: #{inspect(Node.list())}"})
  end
end
