defmodule Countdown.Timers.Timer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timers" do
    field :name, :string
    field :end_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:name, :end_at])
    |> validate_required([:name, :end_at])
  end

  def time_until(%{end_at: end_at}) when not is_nil(end_at) do
    duration = DateTime.diff(end_at, DateTime.utc_now(), :second)

    if duration <= 0 do
      "00:00:00"
    else
      hours = div(duration, 3600)
      remaining = rem(duration, 3600)
      minutes = div(remaining, 60)
      seconds = rem(remaining, 60)

      [hours, minutes, seconds]
      |> Enum.map(&String.pad_leading(Integer.to_string(&1), 2, "0"))
      |> Enum.join(":")
    end
  end

  # Fallback case when end_at is nil
  def time_until(_timer), do: "00:00:00"
end
