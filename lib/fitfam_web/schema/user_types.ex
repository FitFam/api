defmodule FitFamWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  alias FitFamWeb.Resolvers

  @desc "A user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
  end

  object :get_users do
    @desc """
    Get a list of users
    """

    field :users, list_of(:user) do
      resolve(&Resolvers.Users.list_users/2)
    end
  end
end
