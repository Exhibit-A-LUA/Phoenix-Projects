defmodule DiabetesV1.PeriodDatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.PeriodDates` context.
  """

  @doc """
  Generate a period_date.
  """
  def period_date_fixture(attrs \\ %{}) do
    {:ok, period_date} =
      attrs
      |> Enum.into(%{
        start_date: ~D[2025-01-08]
      })
      |> DiabetesV1.PeriodDates.create_period_date()

    period_date
  end
end
