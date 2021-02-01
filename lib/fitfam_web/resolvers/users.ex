defmodule FitFamWeb.Resolvers.Users do
  alias FitFam.Accounts

  def list_users(_args, _context) do
    {:ok, Accounts.list_users()}
  end
end
