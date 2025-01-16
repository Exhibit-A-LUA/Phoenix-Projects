defmodule DiabetesV1.Repo.Migrations.UpdateTimesTable do
  use Ecto.Migration

  def change do
    # Rename reading_time to event_time
    rename table(:times), :reading_time, to: :event_time

    # Add the event_type column with a default of "multiple"
    alter table(:times) do
      add :event_type, :string, default: "multiple", null: false
    end

    # Optional: Add an index to the event_type field for better performance
    create index(:times, [:event_type])
  end
end
