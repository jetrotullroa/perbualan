defmodule Perbualan.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :password_hash, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :password_hash])
    |> validate_required([:username, :password])
    # check uniqueness of the username
    |> unique_constraint(:username)
    # username must have minimum of 6 characters
    |> validate_length(:username, min: 6)
    # password must have minimum of 6 characters
    |> validate_length(:password, min: 6)
    # using hash_password function
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
