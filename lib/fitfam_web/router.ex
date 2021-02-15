defmodule FitFamWeb.Router do
  use FitFamWeb, :router

  alias FitFam.Guardian

  pipeline :graphql do
    plug(FitFamWeb.Context)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :authenticated do
    plug(Guardian.AuthPipeline)
  end

  scope "/api" do
    pipe_through(:graphql)

    forward("/", Absinthe.Plug, schema: FitFamWeb.Schema)
  end

  scope "/auth", FitFamWeb do
    pipe_through([:api])

    get("/facebook", AuthController, :request)
    get("/facebook/callback", AuthController, :callback)
    post("/facebook/callback", AuthController, :callback)
    post("/logout", AuthController, :delete)
  end

  if Mix.env() == :dev do
    scope "/graphiql" do
      pipe_through(:graphql)

      forward("/", Absinthe.Plug.GraphiQL, schema: FitFamWeb.Schema)
    end

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
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: FitFamWeb.Telemetry)
    end
  end
end
