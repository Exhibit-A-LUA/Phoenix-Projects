defmodule DiabetesV1.Times.Time do
  use Ecto.Schema
  import Ecto.Changeset

  schema "times" do
    field :reading_time, :time
    field :blood_sugar, :integer
    field :meal_num, :integer
    field :dose_time, :time
    field :doses, :integer
    field :meal_time, :time
    field :exercise_start, :time
    field :exercise_end, :time

    has_many :meals, DiabetesV1.Meals.Meal
    belongs_to :day, DiabetesV1.Days.Day
    belongs_to :exercise, DiabetesV1.Exercises.Exercise, foreign_key: :exercise_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(time, attrs) do
    time
    |> cast(attrs, [
      :day_id,
      :reading_time,
      :blood_sugar,
      :meal_num,
      :dose_time,
      :doses,
      :meal_time,
      :exercise_start,
      :exercise_end
    ])
    # Ensures exercise_id is valid if provided
    |> assoc_constraint(:exercise)
    |> validate_required([:day_id, :reading_time, :blood_sugar])
    |> unique_constraint([:day_id, :reading_time], name: :times_day_id_reading_time_index)
  end
end
