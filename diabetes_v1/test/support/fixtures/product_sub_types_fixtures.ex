defmodule DiabetesV1.ProductSubTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.ProductSubTypes` context.
  """

  @doc """
  Generate a product_sub_type.
  """
  def product_sub_type_fixture(attrs \\ %{}) do
    {:ok, product_sub_type} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DiabetesV1.ProductSubTypes.create_product_sub_type()

    product_sub_type
  end
end
