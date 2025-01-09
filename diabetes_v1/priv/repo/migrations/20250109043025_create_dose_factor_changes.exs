defmodule DiabetesV1.Repo.Migrations.CreateDoseFactorChanges do
  use Ecto.Migration

  def change do
    create table(:dose_factor_changes) do
      add :change_date, :date
      add :isf_value, :float
      add :icr_value, :float
      add :notes, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:dose_factor_changes, [:user_id])
    create unique_index(:dose_factor_changes, [:user_id, :change_date])
  end
end
