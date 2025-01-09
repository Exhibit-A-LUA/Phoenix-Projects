defmodule DiabetesV1.SensorChangesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.SensorChanges` context.
  """

  @doc """
  Generate a sensor_change.
  """
  def sensor_change_fixture(attrs \\ %{}) do
    {:ok, sensor_change} =
      attrs
      |> Enum.into(%{
        comments: "some comments",
        num_days: 42,
        start_date: ~D[2025-01-08]
      })
      |> DiabetesV1.SensorChanges.create_sensor_change()

    sensor_change
  end
end
