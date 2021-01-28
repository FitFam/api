defmodule FitFam.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :fitfam,
    module: FitFam.Guardian,
    error_handler: FitFam.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
