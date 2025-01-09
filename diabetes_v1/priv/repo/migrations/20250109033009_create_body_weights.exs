defmodule DiabetesV1.Repo.Migrations.CreateBodyWeights do
  use Ecto.Migration

  def change do
    create table(:body_weights) do
      add :reading_date, :date
      add :weight_kg, :float
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:body_weights, [:user_id])
    create unique_index(:body_weights, [:user_id, :reading_date])
  end
end
