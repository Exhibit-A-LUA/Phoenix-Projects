defmodule DiabetesV1.Repo.Migrations.AddUniqueIndexToMeals do
  use Ecto.Migration

  def change do
    create unique_index(:meals, [:time_id, :product_id])
  end
end
