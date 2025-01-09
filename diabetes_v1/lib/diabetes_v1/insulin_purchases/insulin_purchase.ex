defmodule DiabetesV1.InsulinPurchases.InsulinPurchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "insulin_purchases" do
    field :comments, :string
    field :change_date, :date
    field :fiasp_total_doses, :integer
    field :fiasp_initial_doses_used, :integer
    field :tresiba_total_doses, :integer
    field :tresiba_initial_doses_used, :integer
    belongs_to :user, DiabetesV1.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(insulin_purchase, attrs) do
    insulin_purchase
    |> cast(attrs, [
      :user_id,
      :change_date,
      :fiasp_total_doses,
      :fiasp_initial_doses_used,
      :tresiba_total_doses,
      :tresiba_initial_doses_used,
      :comments
    ])
    |> validate_required([:user_id, :change_date])
    |> unique_constraint([:user_id, :change_date],
      name: :insulin_purchases_user_id_change_date_index
    )
  end
end
