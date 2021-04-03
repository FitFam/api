defmodule FitFam.Repo.Migrations.CreateProfileSongsTable do
  use Ecto.Migration

  def change do
    create table(:profile_songs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :artist, :string, null: false
      add :href, :string, null: false
      add :thumbnail_url, :string, null: false
    end
  end
end
