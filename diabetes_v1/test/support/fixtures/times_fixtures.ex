defmodule DiabetesV1.TimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Times` context.
  """

  @doc """
  Generate a time.
  """
  def time_fixture(attrs \\ %{}) do
    {:ok, time} =
      attrs
      |> Enum.into(%{
        blood_sugar: 42,
        dose_time: ~T[14:00:00],
        doses: 42,
        exercise_end: ~T[14:00:00],
        exercise_start: ~T[14:00:00],
        meal_num: 42,
        meal_time: ~T[14:00:00],
        reading_time: ~T[14:00:00]
      })
      |> DiabetesV1.Times.create_time()

    time
  end
end
