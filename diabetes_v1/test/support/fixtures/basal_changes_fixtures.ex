defmodule DiabetesV1.BasalChangesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.BasalChanges` context.
  """

  @doc """
  Generate a basal_change.
  """
  def basal_change_fixture(attrs \\ %{}) do
    {:ok, basal_change} =
      attrs
      |> Enum.into(%{
        change_date: ~D[2025-01-08],
        doses: 42,
        reason: "some reason"
      })
      |> DiabetesV1.BasalChanges.create_basal_change()

    basal_change
  end
end
