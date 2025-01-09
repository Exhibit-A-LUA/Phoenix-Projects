defmodule DiabetesV1.Repo.Migrations.CreateBasalChanges do
  use Ecto.Migration

  def change do
    create table(:basal_changes) do
      add :change_date, :date
      add :doses, :integer
      add :reason, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:basal_changes, [:user_id])
    create unique_index(:basal_changes, [:user_id, :change_date])
  end
end
