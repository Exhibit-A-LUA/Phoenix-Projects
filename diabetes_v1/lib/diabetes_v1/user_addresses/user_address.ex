defmodule DiabetesV1.UserAddresses.UserAddress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_addresses" do
    belongs_to :user, DiabetesV1.Accounts.User
    belongs_to :address, DiabetesV1.Addresses.Address

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_address, attrs) do
    user_address
    |> cast(attrs, [:user_id, :address_id])
    |> validate_required([:user_id, :address_id])
    |> unique_constraint([:user_id, :address_id])
  end
end
