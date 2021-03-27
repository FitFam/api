defmodule FitFam.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :avatar, :string
    field :email, :string
    field :name, :string
    field :username, :string
    field :uid, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :bio, :string
    field :instagram, :string
    field :token, :string


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :uid, :name, :avatar, :username, :password, :bio])
    |> validate_required([:email, :name, :username, :password])
    |> validate_format(:email, ~r/@/) # Check that email is valid
    |> validate_length(:password, min: 8) # Check that password length is >= 8
    |> unique_constraint([:email, :username])
    |> put_password_hash()
    |> put_token()
  end

  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :avatar, :username, :instagram, :bio])
    |> validate_required([:username])
    |> unique_constraint([:username])
  end


  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end

  def valid_password?(%FitFam.Accounts.User{password_hash: password_hash}, password)
    when is_binary(password_hash) and byte_size(password) > 0 do
      Bcrypt.verify_pass(password, password_hash)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  defp put_token(changeset) do
		case changeset do
			%Ecto.Changeset{valid?: true} ->
				put_change(changeset, :token, SecureRandom.urlsafe_base64())
			_ ->
				changeset
		end
	end
end
