defmodule DiabetesV1.Ingredients.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ingredients" do
    field :options, :string
    field :grams, :float
    field :included, :boolean, default: false

    # The product that is a recipe
    belongs_to :product, DiabetesV1.Products.Product, foreign_key: :product_id
    # The product that is an ingredient
    belongs_to :ingredient, DiabetesV1.Products.Product, foreign_key: :ingredient_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:product_id, :ingredient_id, :options, :grams, :included])
    |> validate_required([:product_id, :ingredient_id, :grams, :included])
  end
end
