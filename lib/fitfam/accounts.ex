defmodule FitFam.Accounts do
  @moduledoc """
  The Accounts context.
  """
  require Logger

  import Ecto.Query, warn: false
  alias FitFam.Repo

  alias FitFam.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_by(attr \\ %{}), do: Repo.get_by(attr)

  def find_or_create(%Ueberauth.Auth{} = auth) do
    user =
      email_from_auth(auth)
      |> get_user_for_email()

    if user do
      {:ok, user}
    else
      create_user(basic_info(auth))
    end
  end

  def get_user_for_username(username) do
    Repo.get_by(User, username: username)
  end

  defp get_user_for_email(email) do
    IO.inspect(Repo.get_by(User, email: email))
  end

  # facebook does it this way
  defp avatar_from_auth(%{info: %{image: image}}), do: image

  defp email_from_auth(%{info: %{email: email}}), do: email

  # default case if nothing matches
  defp avatar_from_auth(auth) do
    Logger.warn("#{auth.provider} needs to find an avatar URL!")
    Logger.debug(Jason.encode!(auth))
    nil
  end

  defp basic_info(auth) do
    IO.inspect(auth)
    email = email_from_auth(auth)

    case auth.strategy do
      Ueberauth.Strategy.Facebook ->
        %{
          uid: auth.uid,
          name: name_from_auth(auth),
          email: email,
          avatar: avatar_from_auth(auth),
          provider: "facebook"
        }
    end
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name =
        [auth.info.first_name, auth.info.last_name]
        |> Enum.filter(&(&1 != nil and &1 != ""))

      if Enum.empty?(name) do
        auth.info.nickname
      else
        Enum.join(name, " ")
      end
    end
  end

  defp random_username(name) do

  end
end
