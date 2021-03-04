defmodule FitFam.Repo.Migrations.UpdateUsersTableWithPassword do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :password_hash, :string
      add :is_active, :boolean, default: false, null: false
      modify :email, :string, null: false
    end
  end
end
