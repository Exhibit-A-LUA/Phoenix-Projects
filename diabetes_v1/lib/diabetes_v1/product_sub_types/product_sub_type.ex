defmodule DiabetesV1.ProductSubTypes.ProductSubType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_sub_types" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_sub_type, attrs) do
    product_sub_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
