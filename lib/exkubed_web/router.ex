defmodule ExkubedWeb.Router do
  use ExkubedWeb, :router

  alias ExkubedWeb.Controllers.Orange

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    get("/peel", Orange, :peel)
    get("/", Orange, :bag)
  end
end
