defmodule FitFamWeb.Schema do
  use Absinthe.Schema

  alias FitFamWeb.Schema

  import_types(Schema.UserTypes)
  import_types(Schema.ProfileSongTypes)

  query do
    import_fields(:get_users)
    import_fields(:get_user)
    import_fields(:get_logged_in_user)
    import_fields :profile_song_queries

  end

  mutation do
    import_fields(:update_user)
    import_fields(:create_user)
    import_fields(:login)
  end
end
