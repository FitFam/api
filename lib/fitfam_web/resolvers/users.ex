defmodule FitFamWeb.Resolvers.Users do
  alias FitFam.Accounts

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end

  def get_user(%{id: id}, _context) do
    {:ok, Accounts.get_user!(id)}
  end
end
