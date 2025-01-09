defmodule DiabetesV1.DoseFactorChanges.DoseFactorChange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dose_factor_changes" do
    field :change_date, :date
    field :isf_value, :float
    field :icr_value, :float
    field :notes, :string
    belongs_to :user, DiabetesV1.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(dose_factor_change, attrs) do
    dose_factor_change
    |> cast(attrs, [:user_id, :change_date, :isf_value, :icr_value, :notes])
    |> validate_required([:user_id, :change_date])
    |> unique_constraint([:user_id, :change_date],
      name: :dose_factor_changes_user_id_change_date_index
    )
  end
end
