defmodule DiabetesV1.ProductAliases.ProductAlias do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_aliases" do
    field :alias, :string

    belongs_to :product, DiabetesV1.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_alias, attrs) do
    product_alias
    |> cast(attrs, [:product_id, :alias])
    |> validate_required([:product_id, :alias])
    |> unique_constraint(:alias)
  end
end
