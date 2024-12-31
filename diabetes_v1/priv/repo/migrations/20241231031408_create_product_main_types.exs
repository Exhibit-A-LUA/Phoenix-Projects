defmodule DiabetesV1.Repo.Migrations.CreateProductMainTypes do
  use Ecto.Migration

  def change do
    create table(:product_main_types) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:product_main_types, [:name])
  end
end
