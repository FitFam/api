defmodule FitFam.Repo do
  use Ecto.Repo,
    otp_app: :fitfam,
    adapter: Ecto.Adapters.Postgres
end
