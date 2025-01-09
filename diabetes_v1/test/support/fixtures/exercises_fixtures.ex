defmodule DiabetesV1.ExercisesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Exercises` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        description: "some description",
        intensity: "some intensity",
        met: 120.5,
        type: "some type"
      })
      |> DiabetesV1.Exercises.create_exercise()

    exercise
  end
end
