defmodule ExkubedWeb.Controllers.Orange do
  use ExkubedWeb, :controller

  def peel(conn, _params) do
    json(conn, %{message: "Peeling an orange for you! #{inspect self()}"})
  end
end
