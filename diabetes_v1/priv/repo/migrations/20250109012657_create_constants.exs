defmodule DiabetesV1.Repo.Migrations.CreateConstants do
  use Ecto.Migration

  def change do
    create table(:constants) do
      add :key, :string
      add :value, :float
      add :description, :string
      add :notes, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:constants, [:key])
  end
end
