defmodule DiabetesV1.Repo.Migrations.CreateSensorChanges do
  use Ecto.Migration

  def change do
    create table(:sensor_changes) do
      add :start_date, :date
      add :num_days, :integer
      add :comments, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:sensor_changes, [:user_id])
    create unique_index(:sensor_changes, [:user_id, :start_date])
  end
end
