defmodule DiabetesV1.ProductMainTypesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.ProductMainTypes` context.
  """

  @doc """
  Generate a product_main_type.
  """
  def product_main_type_fixture(attrs \\ %{}) do
    {:ok, product_main_type} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DiabetesV1.ProductMainTypes.create_product_main_type()

    product_main_type
  end
end
