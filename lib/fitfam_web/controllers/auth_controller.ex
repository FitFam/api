defmodule FitFamWeb.AuthController do
  use FitFamWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case FitFam.Accounts.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> redirect(to: "/")
    end
  end
end
