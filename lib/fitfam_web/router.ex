defmodule FitFamWeb.Router do
  use FitFamWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FitFamWeb do
    pipe_through :api
  end

  scope "/auth", FitFamWeb do
    pipe_through([:api])

    get("/facebook", AuthController, :request)
    get("/facebook/callback", AuthController, :callback)
    post("/facebook/callback", AuthController, :callback)
    post("/logout", AuthController, :delete)
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
      live_dashboard "/dashboard", metrics: FitFamWeb.Telemetry
    end
  end
end
