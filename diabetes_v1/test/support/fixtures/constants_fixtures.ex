defmodule DiabetesV1.ConstantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Constants` context.
  """

  @doc """
  Generate a constant.
  """
  def constant_fixture(attrs \\ %{}) do
    {:ok, constant} =
      attrs
      |> Enum.into(%{
        description: "some description",
        key: "some key",
        notes: "some notes",
        value: 120.5
      })
      |> DiabetesV1.Constants.create_constant()

    constant
  end
end
