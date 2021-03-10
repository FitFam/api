defmodule FitFamWeb.Schema do
  use Absinthe.Schema

  alias FitFamWeb.Schema

  import_types(Schema.UserTypes)

  query do
    import_fields(:get_users)
    import_fields(:get_user)
    import_fields(:get_logged_in_user)
  end

  mutation do
    import_fields(:update_user)
    import_fields(:create_user)
    import_fields(:login)
  end
end
