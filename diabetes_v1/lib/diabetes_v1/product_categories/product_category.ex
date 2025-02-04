defmodule DiabetesV1.ProductCategories.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_categories" do
    field :name, :string
    field :description, :string

    has_many :products, DiabetesV1.Products.Product, foreign_key: :category_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_category, attrs) do
    product_category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
