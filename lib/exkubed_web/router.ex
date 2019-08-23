defmodule ExkubedWeb.Router do
  use ExkubedWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExkubedWeb do
    pipe_through :api
  end
end
