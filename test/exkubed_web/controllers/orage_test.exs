defmodule ExkubedWeb.Controllers.OrangeTest do
  use ExkubedWeb.ConnCase, async: true

  alias ExkubedWeb.Controllers.Orange

  test "Should peel an orange", %{conn: conn} do
    resp = Orange.peel(conn, %{})
    assert 200 == resp |> Map.get(:status)
    assert String.contains?(resp |> Map.get(:resp_body), "Peeling an orange for you!")
  end
end
