defmodule DiabetesV1.Days.Day do
  use Ecto.Schema
  import Ecto.Changeset

  schema "days" do
    field :day_date, :date
    field :basal, :integer
    field :icr_fixed, :float
    field :isf_fixed, :float
    field :fiasp_left, :integer
    field :tresiba_left, :integer
    field :sensor_day, :integer
    field :notes, :string
    belongs_to :user, DiabetesV1.Accounts.User
    has_many :times, DiabetesV1.Times.Time

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(day, attrs) do
    day
    |> cast(attrs, [
      :user_id,
      :day_date,
      :basal,
      :icr_fixed,
      :isf_fixed,
      :fiasp_left,
      :tresiba_left,
      :sensor_day,
      :notes
    ])
    |> validate_required([:user_id, :day_date, :basal, :fiasp_left, :tresiba_left, :sensor_day])
    |> unique_constraint([:user_id, :day_date], name: :days_user_id_day_date_index)
  end
end
