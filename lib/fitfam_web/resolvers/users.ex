defmodule FitFamWeb.Resolvers.Users do
  alias FitFam.Accounts

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end

  def get_user(%{username: username}, _context) do
    {:ok, Accounts.get_user_for_username(username)}
  end

  def update_user(%{id: id} = params, %{context: %{current_user: _user}}) do
    case Accounts.get_user!(id) do
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
end
