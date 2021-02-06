defmodule FitFamWeb.AuthController do
  use FitFamWeb, :controller
  plug(Ueberauth)
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
    with {:ok, %FitFam.Accounts.User{} = user} <- FitFam.Accounts.find_or_create(auth),
         {:ok, token, _claims} <- FitFam.Guardian.encode_and_sign(user) do
      conn =
        conn
        |> put_resp_cookie("auth_token", token)
        |> redirect(external: System.get_env("WWW_URL"))
    end
  end
end
