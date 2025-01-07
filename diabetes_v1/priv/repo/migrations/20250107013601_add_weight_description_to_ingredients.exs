defmodule DiabetesV1.Repo.Migrations.AddWeightDescriptionToIngredients do
  use Ecto.Migration

  def change do
    alter table(:ingredients) do
      add :weight_description, :string
    end
  end
end
