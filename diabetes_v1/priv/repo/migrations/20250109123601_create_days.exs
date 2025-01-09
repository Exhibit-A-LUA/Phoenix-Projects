defmodule DiabetesV1.Repo.Migrations.CreateDays do
  use Ecto.Migration

  def change do
    create table(:days) do
      add :day_date, :date
      add :basal, :integer
      add :icr_fixed, :float
      add :isf_fixed, :float
      add :fiasp_left, :integer
      add :tresiba_left, :integer
      add :sensor_day, :integer
      add :notes, :text
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:days, [:user_id, :day_date])
    create index(:days, [:user_id])
  end
end
