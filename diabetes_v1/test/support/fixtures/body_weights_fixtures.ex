defmodule DiabetesV1.BodyWeightsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.BodyWeights` context.
  """

  @doc """
  Generate a body_weight.
  """
  def body_weight_fixture(attrs \\ %{}) do
    {:ok, body_weight} =
      attrs
      |> Enum.into(%{
        reading_date: ~D[2025-01-08],
        weight_kg: 120.5
      })
      |> DiabetesV1.BodyWeights.create_body_weight()

    body_weight
  end
end
