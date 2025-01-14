defmodule DiabetesV1.Repo.Migrations.AddUniqueIndexToUserAddresses do
  use Ecto.Migration

  def change do
    execute("""
    CREATE UNIQUE INDEX IF NOT EXISTS user_addresses_user_id_address_id_index
    ON user_addresses (user_id, address_id)
    """)
  end
end
