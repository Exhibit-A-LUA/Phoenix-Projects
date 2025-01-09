defmodule DiabetesV1.DoseFactorChangesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.DoseFactorChanges` context.
  """

  @doc """
  Generate a dose_factor_change.
  """
  def dose_factor_change_fixture(attrs \\ %{}) do
    {:ok, dose_factor_change} =
      attrs
      |> Enum.into(%{
        change_date: ~D[2025-01-08],
        icr_value: 120.5,
        isf_value: 120.5,
        notes: "some notes"
      })
      |> DiabetesV1.DoseFactorChanges.create_dose_factor_change()

    dose_factor_change
  end
end
