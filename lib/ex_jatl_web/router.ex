defmodule ExJatlWeb.Router do
  use ExJatlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExJatlWeb, as: :api do
    pipe_through :api

    scope "/v1", Api.V1, as: :api_v1 do
      get "/todos/search/:search_query", TodoController, :search
      resources "/todos", TodoController, except: [:new, :edit]
    end
  end

  scope "/", ExJatlWeb do
    pipe_through :browser
    get "/", PageController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ExJatlWeb.Telemetry
    end
  end
end
