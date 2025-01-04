defmodule DiabetesV1.IngredientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Ingredients` context.
  """

  @doc """
  Generate a ingredient.
  """
  def ingredient_fixture(attrs \\ %{}) do
    {:ok, ingredient} =
      attrs
      |> Enum.into(%{
        grams: 120.5,
        included: true,
        options: "some options"
      })
      |> DiabetesV1.Ingredients.create_ingredient()

    ingredient
  end
end
