defmodule DiabetesV1.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.Products.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  defp calc_sum(_name, sum, nil, _fraction), do: sum

  defp calc_sum(_name, sum, new, fraction) do
    # IO.puts("updating #{name},  #{sum} + #{new} * #{fraction}")
    sum + new * fraction
  end

  # calculate nutritional content for a product/recipe based on its ingredients.
  defp calculate_nutrition(recipe_id) do
    # Fetch all ingredients for the recipe
    ingredients =
      Repo.all(
        from i in DiabetesV1.Ingredients.Ingredient,
          # Join on the product that is an ingredient
          join: p in assoc(i, :ingredient),
          where: i.product_id == ^recipe_id and i.included == true,
          select: %{grams: i.grams, ingredient: p}
      )

    # Sum up the nutritional values
    Enum.reduce(
      ingredients,
      %{
        calories_kcal: 0.0,
        carbs_g: 0.0,
        fibre_g: 0.0,
        starch_g: 0.0,
        sugars_g: 0.0,
        sugar_alcohol_g: 0.0,
        protein_g: 0.0,
        fat_g: 0.0,
        mono_g: 0.0,
        trans_g: 0.0,
        poly_g: 0.0,
        sat_g: 0.0,
        cholesterol_mg: 0.0,
        calcium_mg: 0.0,
        iron_mg: 0.0,
        magnesium_mg: 0.0,
        phosphorus_mg: 0.0,
        potassium_mg: 0.0,
        sodium_mg: 0.0,
        zinc_mg: 0.0,
        copper_mg: 0.0,
        selenium_mcg: 0.0,
        v_b9_folate_mcg: 0.0,
        v_a_retinol_mcg: 0.0,
        v_b1_thiamin_mg: 0.0,
        v_b2_riboflavin_mg: 0.0,
        v_b3_niacin_mg: 0.0,
        v_b5_mg: 0.0,
        v_b6_mg: 0.0,
        v_b12_mg: 0.0,
        v_c_ascorbic_acid_mg: 0.0,
        v_d_mcg: 0.0,
        v_k_mcg: 0.0,
        v_e_mg: 0.0,
        choline_mg: 0.0,
        glycemix_index: 0.0
      },
      fn %{grams: grams, ingredient: ingredient}, acc ->
        # Scale by the ingredient's serving size
        multiplier = grams / ingredient.serving_g

        %{
          calories_kcal:
            calc_sum("calories_kcal", acc.calories_kcal, ingredient.calories_kcal, multiplier),
          carbs_g: calc_sum("carbs_g", acc.carbs_g, ingredient.carbs_g, multiplier),
          fibre_g: calc_sum("fibre_g", acc.fibre_g, ingredient.fibre_g, multiplier),
          starch_g: calc_sum("starch_g", acc.starch_g, ingredient.starch_g, multiplier),
          sugars_g: calc_sum("sugars_g", acc.sugars_g, ingredient.sugars_g, multiplier),
          sugar_alcohol_g:
            calc_sum(
              "sugar_alcohol_g",
              acc.sugar_alcohol_g,
              ingredient.sugar_alcohol_g,
              multiplier
            ),
          protein_g: calc_sum("protein_g", acc.protein_g, ingredient.protein_g, multiplier),
          fat_g: calc_sum("fat_g", acc.fat_g, ingredient.fat_g, multiplier),
          mono_g: calc_sum("mono_g", acc.mono_g, ingredient.mono_g, multiplier),
          trans_g: calc_sum("trans_g", acc.trans_g, ingredient.trans_g, multiplier),
          poly_g: calc_sum("poly_g", acc.poly_g, ingredient.poly_g, multiplier),
          sat_g: calc_sum("sat_g", acc.sat_g, ingredient.sat_g, multiplier),
          cholesterol_mg:
            calc_sum("cholesterol_mg", acc.cholesterol_mg, ingredient.cholesterol_mg, multiplier),
          calcium_mg: calc_sum("calcium_mg", acc.calcium_mg, ingredient.calcium_mg, multiplier),
          iron_mg: calc_sum("iron_mg", acc.iron_mg, ingredient.iron_mg, multiplier),
          magnesium_mg:
            calc_sum("magnesium_mg", acc.magnesium_mg, ingredient.magnesium_mg, multiplier),
          phosphorus_mg:
            calc_sum("phosphorus_mg", acc.phosphorus_mg, ingredient.phosphorus_mg, multiplier),
          potassium_mg:
            calc_sum("potassium_mg", acc.potassium_mg, ingredient.potassium_mg, multiplier),
          sodium_mg: calc_sum("sodium_mg", acc.sodium_mg, ingredient.sodium_mg, multiplier),
          zinc_mg: calc_sum("zinc_mg", acc.zinc_mg, ingredient.zinc_mg, multiplier),
          copper_mg: calc_sum("copper_mg", acc.copper_mg, ingredient.copper_mg, multiplier),
          selenium_mcg:
            calc_sum("selenium_mcg", acc.selenium_mcg, ingredient.selenium_mcg, multiplier),
          v_b9_folate_mcg:
            calc_sum(
              "v_b9_folate_mcg",
              acc.v_b9_folate_mcg,
              ingredient.v_b9_folate_mcg,
              multiplier
            ),
          v_a_retinol_mcg:
            calc_sum(
              "v_a_retinol_mcg",
              acc.v_a_retinol_mcg,
              ingredient.v_a_retinol_mcg,
              multiplier
            ),
          v_b1_thiamin_mg:
            calc_sum(
              "v_b1_thiamin_mg",
              acc.v_b1_thiamin_mg,
              ingredient.v_b1_thiamin_mg,
              multiplier
            ),
          v_b2_riboflavin_mg:
            calc_sum(
              "v_b2_riboflavin_mg",
              acc.v_b2_riboflavin_mg,
              ingredient.v_b2_riboflavin_mg,
              multiplier
            ),
          v_b3_niacin_mg:
            calc_sum("v_b3_niacin_mg", acc.v_b3_niacin_mg, ingredient.v_b3_niacin_mg, multiplier),
          v_b5_mg: calc_sum("v_b5_mg", acc.v_b5_mg, ingredient.v_b5_mg, multiplier),
          v_b6_mg: calc_sum("v_b6_mg", acc.v_b6_mg, ingredient.v_b6_mg, multiplier),
          v_b12_mg: calc_sum("v_b12_mg", acc.v_b12_mg, ingredient.v_b12_mg, multiplier),
          v_c_ascorbic_acid_mg:
            calc_sum(
              "v_c_ascorbic_acid_mg",
              acc.v_c_ascorbic_acid_mg,
              ingredient.v_c_ascorbic_acid_mg,
              multiplier
            ),
          v_d_mcg: calc_sum("v_d_mcg", acc.v_d_mcg, ingredient.v_d_mcg, multiplier),
          v_k_mcg: calc_sum("v_k_mcg", acc.v_k_mcg, ingredient.v_k_mcg, multiplier),
          v_e_mg: calc_sum("v_e_mg", acc.v_e_mg, ingredient.v_e_mg, multiplier),
          choline_mg: calc_sum("choline_mg", acc.choline_mg, ingredient.choline_mg, multiplier),
          glycemix_index:
            calc_sum("glycemix_index", acc.glycemix_index, ingredient.glycemix_index, multiplier)
        }
      end
    )
  end

  # Update the Product/Recipe's Nutritional Content
  def update_recipe_nutrition(recipe_id) do
    nutrition = calculate_nutrition(recipe_id)

    Repo.update_all(
      from(p in DiabetesV1.Products.Product, where: p.id == ^recipe_id),
      set: [
        calories_kcal: nutrition.calories_kcal,
        carbs_g: nutrition.carbs_g,
        fibre_g: nutrition.fibre_g,
        starch_g: nutrition.starch_g,
        sugars_g: nutrition.sugars_g,
        sugar_alcohol_g: nutrition.sugar_alcohol_g,
        protein_g: nutrition.protein_g,
        fat_g: nutrition.fat_g,
        mono_g: nutrition.mono_g,
        trans_g: nutrition.trans_g,
        poly_g: nutrition.poly_g,
        sat_g: nutrition.sat_g,
        cholesterol_mg: nutrition.cholesterol_mg,
        calcium_mg: nutrition.calcium_mg,
        iron_mg: nutrition.iron_mg,
        magnesium_mg: nutrition.magnesium_mg,
        phosphorus_mg: nutrition.phosphorus_mg,
        potassium_mg: nutrition.potassium_mg,
        sodium_mg: nutrition.sodium_mg,
        zinc_mg: nutrition.zinc_mg,
        copper_mg: nutrition.copper_mg,
        selenium_mcg: nutrition.selenium_mcg,
        v_b9_folate_mcg: nutrition.v_b9_folate_mcg,
        v_a_retinol_mcg: nutrition.v_a_retinol_mcg,
        v_b1_thiamin_mg: nutrition.v_b1_thiamin_mg,
        v_b2_riboflavin_mg: nutrition.v_b2_riboflavin_mg,
        v_b3_niacin_mg: nutrition.v_b3_niacin_mg,
        v_b5_mg: nutrition.v_b5_mg,
        v_b6_mg: nutrition.v_b6_mg,
        v_b12_mg: nutrition.v_b12_mg,
        v_c_ascorbic_acid_mg: nutrition.v_c_ascorbic_acid_mg,
        v_d_mcg: nutrition.v_d_mcg,
        v_k_mcg: nutrition.v_k_mcg,
        v_e_mg: nutrition.v_e_mg,
        choline_mg: nutrition.choline_mg,
        glycemix_index: nutrition.glycemix_index
      ]
    )
  end
end
