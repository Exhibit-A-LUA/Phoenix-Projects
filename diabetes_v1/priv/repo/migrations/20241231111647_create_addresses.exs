defmodule DiabetesV1.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :address_line1, :string, null: false
      add :address_line2, :string
      add :city, :string, null: false
      add :postal_code, :string, null: false
      add :country, :string, null: false
      add :telephone, :string

      timestamps(type: :utc_datetime)
    end
  end
end
