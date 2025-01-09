defmodule DiabetesV1.Meals.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meals" do
    field :meal_num, :integer
    field :qty, :float
    field :weight, :float

    belongs_to :time, DiabetesV1.Times.Time
    belongs_to :product, DiabetesV1.Products.Product, foreign_key: :product_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:time_id, :meal_num, :product_id, :qty, :weight])
    |> validate_required([:time_id, :meal_num, :product_id, :weight])
    |> unique_constraint([:time_id, :product_id], name: :meals_time_id_product_id_index)
  end
end
