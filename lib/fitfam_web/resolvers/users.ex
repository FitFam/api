defmodule FitFamWeb.Resolvers.Users do
  alias FitFam.Accounts

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end

  def get_user(%{username: username}, _context) do
    {:ok, Accounts.get_user_for_username(username)}
  end
end
