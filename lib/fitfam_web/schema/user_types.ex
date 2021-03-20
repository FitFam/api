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
    field :instagram, :string
    field :bio, :string
  end

  @desc "session value"
  object :session do
    field(:auth_token, :string)
    field(:user, :user)
  end

  object :login do
    @desc """
      Login with username and password
    """

    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Users.login/2)
    end
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
      arg(:username, :string)
      arg(:bio, :string)
      arg(:instagram, :string)

      resolve(&Resolvers.Users.update_user/2)
    end
  end

  object :get_logged_in_user do
    @desc """
    Get currently logged in user
    """

    field :get_logged_in_user, :user do
      resolve(&Resolvers.Users.get_logged_in_user/2)
    end
  end

  object :create_user do
    @desc """
      create user
    """

    @desc "Create a user"
    field :create_user, :session do
      arg(:email, non_null(:string))
      arg(:name, non_null(:string))
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Users.create_user/3)
    end
  end
end
