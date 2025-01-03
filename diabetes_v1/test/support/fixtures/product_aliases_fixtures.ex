defmodule DiabetesV1.ProductAliasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.ProductAliases` context.
  """

  @doc """
  Generate a product_alias.
  """
  def product_alias_fixture(attrs \\ %{}) do
    {:ok, product_alias} =
      attrs
      |> Enum.into(%{
        alias: "some alias",
        string: "some string"
      })
      |> DiabetesV1.ProductAliases.create_product_alias()

    product_alias
  end
end
