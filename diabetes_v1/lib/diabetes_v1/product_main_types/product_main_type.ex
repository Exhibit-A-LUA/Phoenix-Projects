defmodule DiabetesV1.ProductMainTypes.ProductMainType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_main_types" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_main_type, attrs) do
    product_main_type
    # allow 'id' temporarily
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
