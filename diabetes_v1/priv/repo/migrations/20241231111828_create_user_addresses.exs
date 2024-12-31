defmodule DiabetesV1.Repo.Migrations.CreateUserAddresses do
  use Ecto.Migration

  def change do
    create table(:user_addresses) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :address_id, references(:addresses, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:user_addresses, [:user_id, :address_id])
    create index(:user_addresses, [:user_id])
    create index(:user_addresses, [:address_id])
  end
end
