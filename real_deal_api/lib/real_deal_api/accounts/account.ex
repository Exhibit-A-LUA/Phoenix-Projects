defmodule RealDealApi.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :hash_password, :string
    has_one :user, RealDealApi.Users.User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  # call the changeset struct if its valid then store hashed password in variable hash_password
  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset
       ) do
    # change our object and return the password we passed in into a hash value
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end

  # if changset is not valie just return the changeset
  defp put_password_hash(changeset), do: changeset
end
