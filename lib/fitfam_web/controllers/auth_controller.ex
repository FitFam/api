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
    with {:ok, user} <- FitFam.Accounts.create_user(auth),
         {:ok, token, _claims} <- FitFam.Guardian.encode_and_sign(user) do
      conn |> json(%{access_token: token})
    end
  end
end
