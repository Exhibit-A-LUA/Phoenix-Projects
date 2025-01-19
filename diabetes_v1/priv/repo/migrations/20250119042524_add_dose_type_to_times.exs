defmodule DiabetesV1.Repo.Migrations.AddDoseTypeToTimes do
  use Ecto.Migration

  def change do
    alter table(:times) do
      add :dose_type, :string, default: nil
    end
  end
end
