defmodule DiabetesV1.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        calcium_mg: 120.5,
        calories_kcal: 120.5,
        carbs_g: 120.5,
        cholesterol_mg: 120.5,
        choline_mg: 120.5,
        copper_mg: 120.5,
        description: "some description",
        fat_g: 120.5,
        fibre_g: 120.5,
        glycemix_index: 120.5,
        iron_mg: 120.5,
        magnesium_mg: 120.5,
        mono_g: 120.5,
        name: "some name",
        phosphorus_mg: 120.5,
        poly_g: 120.5,
        potassium_mg: 120.5,
        protein_g: 120.5,
        sat_g: 120.5,
        selenium_mcg: 120.5,
        serving_descr: "some serving_descr",
        serving_g: 120.5,
        sodium_mg: 120.5,
        starch_g: 120.5,
        sugar_alcohol_g: 120.5,
        sugars_g: 120.5,
        trans_g: 120.5,
        v_a_retinol_mcg: 120.5,
        v_b12_mg: 120.5,
        v_b1_thiamin_mg: 120.5,
        v_b2_riboflavin_mg: 120.5,
        v_b3_niacin_mg: 120.5,
        v_b5_mg: 120.5,
        v_b6_mg: 120.5,
        v_b9_folate_mcg: 120.5,
        v_c_ascorbic_acid_mg: 120.5,
        v_d_mcg: 120.5,
        v_e_mg: 120.5,
        v_k_mcg: 120.5,
        zinc_mg: 120.5
      })
      |> DiabetesV1.Products.create_product()

    product
  end
end
