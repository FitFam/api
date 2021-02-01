defmodule FitFamWeb.Schema do
  use Absinthe.Schema

  alias FitFamWeb.Schema

  import_types(Schema.UserTypes)

  query do
    import_fields(:get_users)
  end
end
