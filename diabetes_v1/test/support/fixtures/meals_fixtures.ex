defmodule DiabetesV1.MealsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Meals` context.
  """

  @doc """
  Generate a meal.
  """
  def meal_fixture(attrs \\ %{}) do
    {:ok, meal} =
      attrs
      |> Enum.into(%{
        meal_num: 42,
        qty: 120.5,
        weight: 120.5
      })
      |> DiabetesV1.Meals.create_meal()

    meal
  end
end
