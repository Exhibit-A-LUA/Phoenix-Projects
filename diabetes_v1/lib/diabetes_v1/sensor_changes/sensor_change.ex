defmodule DiabetesV1.SensorChanges.SensorChange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sensor_changes" do
    field :comments, :string
    field :start_date, :date
    field :num_days, :integer
    belongs_to :user, DiabetesV1.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sensor_change, attrs) do
    sensor_change
    |> cast(attrs, [:user_id, :start_date, :num_days, :comments])
    |> validate_required([:user_id, :start_date, :num_days])
    |> unique_constraint([:user_id, :start_date], name: :sensor_changes_user_id_start_date_index)
  end
end
