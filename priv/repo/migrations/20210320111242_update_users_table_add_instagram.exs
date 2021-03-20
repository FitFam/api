defmodule FitFam.Repo.Migrations.UpdateUsersTableAddInstagram do
  use Ecto.Migration

  def change do
    alter table("users") do
      add(:instagram, :string)
    end
  end
end
