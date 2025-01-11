defmodule Countdown.TimersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Countdown.Timers` context.
  """

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{
        end_at: ~U[2025-01-10 08:37:00Z],
        name: "some name"
      })
      |> Countdown.Timers.create_timer()

    timer
  end
end
