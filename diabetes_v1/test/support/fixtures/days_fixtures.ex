defmodule DiabetesV1.DaysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Days` context.
  """

  @doc """
  Generate a day.
  """
  def day_fixture(attrs \\ %{}) do
    {:ok, day} =
      attrs
      |> Enum.into(%{
        basal: 42,
        day_date: ~D[2025-01-08],
        fiasp_left: 42,
        icr_fixed: 120.5,
        isf_fixed: 120.5,
        notes: "some notes",
        sensor_day: 42,
        tresiba_left: 42
      })
      |> DiabetesV1.Days.create_day()

    day
  end
end
