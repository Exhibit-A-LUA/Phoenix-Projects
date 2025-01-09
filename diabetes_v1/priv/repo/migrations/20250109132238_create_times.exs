defmodule DiabetesV1.Repo.Migrations.CreateTimes do
  use Ecto.Migration

  def change do
    create table(:times) do
      add :reading_time, :time
      add :blood_sugar, :integer
      add :meal_num, :integer
      add :dose_time, :time
      add :doses, :integer
      add :meal_time, :time
      add :exercise_start, :time
      add :exercise_end, :time
      add :day_id, references(:days, on_delete: :delete_all), null: false
      add :exercise_id, references(:exercises, on_delete: :nilify_all), null: true

      timestamps(type: :utc_datetime)
    end

    create index(:times, [:day_id])
    create index(:times, [:exercise_id])
    create unique_index(:times, [:day_id, :reading_time])
  end
end
