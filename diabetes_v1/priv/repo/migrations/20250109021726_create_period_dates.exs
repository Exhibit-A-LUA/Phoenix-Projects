defmodule DiabetesV1.Repo.Migrations.CreatePeriodDates do
  use Ecto.Migration

  def change do
    create table(:period_dates) do
      add :start_date, :date
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:period_dates, [:user_id])
    create unique_index(:period_dates, [:user_id, :start_date])
  end
end
