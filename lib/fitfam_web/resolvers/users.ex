defmodule FitFamWeb.Resolvers.Users do
  alias FitFam.Accounts
  alias FitFam.Guardian

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end

  def get_user(%{username: username}, _context) do
    {:ok, Accounts.get_user_for_username(username)}
  end

  def create_user(_parent, args, _context) do
    with {:ok, %Accounts.User{} = user} <- Accounts.create_user(args),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{auth_token: token, user: user}}
    end
  end

  def update_user(params, %{context: %{current_user: _user}}) do
    case Accounts.get_user!(_user.id) do
      nil ->
      {:error, "User not found"}

      %Accounts.User{} = user ->
        case Accounts.update_user(user, params) do
          {:ok, %Accounts.User{} = user} -> {:ok, user}
          {:error, changeset} -> {:error, inspect(changeset.errors)}
        end
    end
  end

  def update_user(_args, _context), do: {:error, "Not Authorized"}

  def get_logged_in_user(_args, %{context: %{current_user: _user}}) do
    {:ok, Accounts.get_user!(_user.id)}
  end

  def get_logged_in_user(_args, _context), do: {:error, "Not Authorized"}
end
