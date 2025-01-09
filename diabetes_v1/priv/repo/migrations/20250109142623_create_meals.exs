defmodule DiabetesV1.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :meal_num, :integer
      add :qty, :float
      add :weight, :float
      add :time_id, references(:times, on_delete: :delete_all), null: false
      add :product_id, references(:products, on_delete: :nilify_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:meals, [:time_id])
    create index(:meals, [:product_id])
  end
end
