defmodule DiabetesV1.BasalChanges.BasalChange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "basal_changes" do
    field :reason, :string
    field :change_date, :date
    field :doses, :integer
    belongs_to :user, DiabetesV1.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(basal_change, attrs) do
    basal_change
    |> cast(attrs, [:user_id, :change_date, :doses, :reason])
    |> validate_required([:user_id, :change_date, :doses])
    |> unique_constraint([:user_id, :change_date], name: :basal_changes_user_id_change_date_index)
  end
end
