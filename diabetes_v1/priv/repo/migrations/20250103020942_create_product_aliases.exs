defmodule DiabetesV1.Repo.Migrations.CreateProductAliases do
  use Ecto.Migration

  def change do
    create table(:product_aliases) do
      add :alias, :string
      add :product_id, references(:products, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:product_aliases, [:product_id])
    create unique_index(:product_aliases, [:alias])
  end
end
