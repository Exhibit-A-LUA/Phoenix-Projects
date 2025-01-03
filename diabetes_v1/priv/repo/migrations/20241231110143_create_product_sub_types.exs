defmodule DiabetesV1.Repo.Migrations.CreateProductSubTypes do
  use Ecto.Migration

  def change do
    create table(:product_sub_types) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:product_sub_types, [:name])
  end
end
