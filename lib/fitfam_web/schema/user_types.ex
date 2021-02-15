defmodule FitFamWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation

  alias FitFamWeb.Resolvers

  @desc "A user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :avatar, :string
    field :username, :string
  end

  object :get_users do
    @desc """
    Get a list of users
    """

    field :users, list_of(:user) do
      resolve(&Resolvers.Users.list_users/2)
    end
  end

  object :get_user do
    @desc """
      Get a specific user
    """

    field :user, :user do
      arg(:username, non_null(:string))

      resolve(&Resolvers.Users.get_user/2)
    end
  end

  object :update_user do
    @desc """
      Update a user
    """

    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:username, :string)

      resolve(&Resolvers.Users.update_user/2)
    end
  end
end
