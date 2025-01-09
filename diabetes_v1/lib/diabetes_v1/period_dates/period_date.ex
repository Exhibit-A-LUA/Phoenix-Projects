defmodule DiabetesV1.PeriodDates.PeriodDate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "period_dates" do
    field :start_date, :date
    belongs_to :user, DiabetesV1.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(period_date, attrs) do
    period_date
    |> cast(attrs, [:start_date, :user_id])
    |> validate_required([:start_date, :user_id])
    |> unique_constraint([:user_id, :start_date], name: :period_dates_user_id_start_date_index)
  end
end
