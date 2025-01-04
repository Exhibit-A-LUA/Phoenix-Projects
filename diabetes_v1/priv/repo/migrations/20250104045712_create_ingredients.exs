defmodule DiabetesV1.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :options, :string
      add :grams, :float
      add :included, :boolean, default: false, null: false
      add :product_id, references(:products, on_delete: :delete_all), null: false
      add :ingredient_id, references(:products, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:ingredients, [:product_id])
    create index(:ingredients, [:ingredient_id])
  end
end
