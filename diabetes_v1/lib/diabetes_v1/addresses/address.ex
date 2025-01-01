defmodule DiabetesV1.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :address_line1, :string
    field :address_line2, :string
    field :city, :string
    field :postal_code, :string
    field :country, :string
    field :telephone, :string

    many_to_many :users, DiabetesV1.Accounts.User, join_through: "user_addresses"
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:address_line1, :address_line2, :city, :postal_code, :country, :telephone])
    |> validate_required([
      :address_line1,
      :address_line2,
      :city,
      :postal_code,
      :country,
      :telephone
    ])
  end
end
