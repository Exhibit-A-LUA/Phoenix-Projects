defmodule DiabetesV1.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :type, :string
      add :intensity, :string
      add :met, :float
      add :description, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:exercises, [:type])
  end
end
