defmodule DiabetesV1.Repo.Migrations.CreateInsulinPurchases do
  use Ecto.Migration

  def change do
    create table(:insulin_purchases) do
      add :change_date, :date
      add :fiasp_total_doses, :integer
      add :fiasp_initial_doses_used, :integer
      add :tresiba_total_doses, :integer
      add :tresiba_initial_doses_used, :integer
      add :comments, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:insulin_purchases, [:user_id])
    create unique_index(:insulin_purchases, [:user_id, :change_date])
  end
end
