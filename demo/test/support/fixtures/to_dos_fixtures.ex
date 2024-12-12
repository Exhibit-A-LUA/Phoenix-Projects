defmodule Demo.ToDosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.ToDos` context.
  """

  @doc """
  Generate a to_do.
  """
  def to_do_fixture(attrs \\ %{}) do
    {:ok, to_do} =
      attrs
      |> Enum.into(%{
        deadline: ~U[2024-11-28 04:36:00Z],
        done: true,
        name: "some name"
      })
      |> Demo.ToDos.create_to_do()

    to_do
  end
end
