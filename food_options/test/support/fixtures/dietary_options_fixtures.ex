defmodule FoodOptions.DietaryOptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodOptions.DietaryOptions` context.
  """

  @doc """
  Generate a dietary_option.
  """
  def dietary_option_fixture(attrs \\ %{}) do
    {:ok, dietary_option} =
      attrs
      |> Enum.into(%{

      })
      |> FoodOptions.DietaryOptions.create_dietary_option()

    dietary_option
  end
end
