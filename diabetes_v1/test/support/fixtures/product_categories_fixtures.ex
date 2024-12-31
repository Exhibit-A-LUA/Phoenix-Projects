defmodule DiabetesV1.ProductCategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.ProductCategories` context.
  """

  @doc """
  Generate a product_category.
  """
  def product_category_fixture(attrs \\ %{}) do
    {:ok, product_category} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> DiabetesV1.ProductCategories.create_product_category()

    product_category
  end
end
