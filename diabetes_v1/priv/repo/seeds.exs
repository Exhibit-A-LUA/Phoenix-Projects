# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DiabetesV1.Repo.insert!(%DiabetesV1.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule MySeeder do
  alias DiabetesV1.Repo
  alias DiabetesV1.ProductMainTypes
  alias DiabetesV1.ProductMainTypes.ProductMainType
  alias DiabetesV1.ProductSubTypes
  alias DiabetesV1.ProductSubTypes.ProductSubType
  alias DiabetesV1.ProductCategories
  alias DiabetesV1.ProductCategories.ProductCategory
  alias DiabetesV1.Products
  alias DiabetesV1.Products.Product
  alias DiabetesV1.ProductAliases
  alias DiabetesV1.Ingredients
  alias DiabetesV1.Constants
  alias DiabetesV1.Exercises
  alias DiabetesV1.PeriodDates
  alias DiabetesV1.BodyWeights
  alias DiabetesV1.BasalChanges
  alias DiabetesV1.DoseFactorChanges
  alias DiabetesV1.InsulinPurchases

  import Ecto.Query

  # ! ProductMainTypes
  # Seed product_main_types from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(ProductMainType)

  def seed_product_main_types_data do
    IO.puts("Seeding product_main_types...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/product_main_types.csv"))
    |> Enum.each(fn [id, name, description] ->
      case ProductMainTypes.create_product_main_type(%{
             id: String.to_integer(id),
             name: String.trim(name),
             description: String.trim(description)
           }) do
        {:ok, _product_main_type} -> IO.puts("Product Main Type #{name} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! ProductSubTypes
  # # Seed product_sub_types from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(ProductSubType)

  def seed_product_sub_types_data do
    IO.puts("Seeding product_sub_types...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/product_sub_types.csv"))
    |> Enum.each(fn [id, name, description] ->
      case ProductSubTypes.create_product_sub_type(%{
             id: String.to_integer(id),
             name: String.trim(name),
             description: String.trim(description)
           }) do
        {:ok, _product_sub_type} -> IO.puts("Product Sub Type #{name} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! ProductCategories
  # # Seed product_categories from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(ProductCategory)

  def seed_product_categories_data do
    IO.puts("Seeding product_categories...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/product_categories.csv"))
    |> Enum.each(fn [id, name, description] ->
      case ProductCategories.create_product_category(%{
             id: String.to_integer(id),
             name: String.trim(name),
             description: String.trim(description)
           }) do
        {:ok, _product_category} -> IO.puts("Product Category #{name} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # * Products
  # Helper function to fetch ID by name
  defp get_id_by_name(module, name) do
    case Repo.get_by(module, name: name) do
      %^module{id: id} ->
        id

      nil ->
        # Handle aliases only for the `Products` module
        if module == DiabetesV1.Products.Product do
          case Repo.get_by(DiabetesV1.ProductAliases.ProductAlias, alias: name) do
            %DiabetesV1.ProductAliases.ProductAlias{product_id: product_id} ->
              product_id

            nil ->
              IO.puts("Warning: Product or alias '#{name}' not found.")
              nil
          end
        else
          IO.puts("Warning: '#{name}' not found in #{inspect(module)}.")
          nil
        end
    end
  end

  # Helper function to ensure floats are done correctly
  defp get_float(""), do: 0.0

  defp get_float(value) do
    # IO.inspect(value, label: "Value passed to get_float")
    value
    |> Float.parse()
    |> elem(0)
  end

  # ! Products
  # # Seed products from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(Product)

  def seed_product_data do
    IO.puts("Seeding products...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/products.csv"))
    |> Enum.each(fn [
                      id,
                      main_type_name,
                      sub_type_name,
                      category_name,
                      description,
                      name,
                      serving_g,
                      serving_descr,
                      calories_kcal,
                      carbs_g,
                      fibre_g,
                      starch_g,
                      sugars_g,
                      sugar_alcohol_g,
                      protein_g,
                      fat_g,
                      mono_g,
                      trans_g,
                      poly_g,
                      sat_g,
                      cholesterol_mg,
                      calcium_mg,
                      iron_mg,
                      magnesium_mg,
                      phosphorus_mg,
                      potassium_mg,
                      sodium_mg,
                      zinc_mg,
                      copper_mg,
                      selenium_mcg,
                      v_b9_folate_mcg,
                      v_a_retinol_mcg,
                      v_b1_thiamin_mg,
                      v_b2_riboflavin_mg,
                      v_b3_niacin_mg,
                      v_b5_mg,
                      v_b6_mg,
                      v_b12_mg,
                      v_c_ascorbic_acid_mg,
                      v_d_mcg,
                      v_k_mcg,
                      v_e_mg,
                      choline_mg,
                      glycemix_index
                    ] ->
      case Products.create_product(%{
             id: String.to_integer(id),
             name: String.trim(name),
             description: String.trim(description),
             main_type_id: get_id_by_name(ProductMainType, main_type_name),
             sub_type_id: get_id_by_name(ProductSubType, sub_type_name),
             category_id: get_id_by_name(ProductCategory, category_name),
             serving_g: get_float(serving_g),
             serving_descr: String.trim(serving_descr),
             calories_kcal: get_float(calories_kcal),
             carbs_g: get_float(carbs_g),
             fibre_g: get_float(fibre_g),
             starch_g: get_float(starch_g),
             sugars_g: get_float(sugars_g),
             sugar_alcohol_g: get_float(sugar_alcohol_g),
             protein_g: get_float(protein_g),
             fat_g: get_float(fat_g),
             mono_g: get_float(mono_g),
             trans_g: get_float(trans_g),
             poly_g: get_float(poly_g),
             sat_g: get_float(sat_g),
             cholesterol_mg: get_float(cholesterol_mg),
             calcium_mg: get_float(calcium_mg),
             iron_mg: get_float(iron_mg),
             magnesium_mg: get_float(magnesium_mg),
             phosphorus_mg: get_float(phosphorus_mg),
             potassium_mg: get_float(potassium_mg),
             sodium_mg: get_float(sodium_mg),
             zinc_mg: get_float(zinc_mg),
             copper_mg: get_float(copper_mg),
             selenium_mcg: get_float(selenium_mcg),
             v_b9_folate_mcg: get_float(v_b9_folate_mcg),
             v_a_retinol_mcg: get_float(v_a_retinol_mcg),
             v_b1_thiamin_mg: get_float(v_b1_thiamin_mg),
             v_b2_riboflavin_mg: get_float(v_b2_riboflavin_mg),
             v_b3_niacin_mg: get_float(v_b3_niacin_mg),
             v_b5_mg: get_float(v_b5_mg),
             v_b6_mg: get_float(v_b6_mg),
             v_b12_mg: get_float(v_b12_mg),
             v_c_ascorbic_acid_mg: get_float(v_c_ascorbic_acid_mg),
             v_d_mcg: get_float(v_d_mcg),
             v_k_mcg: get_float(v_k_mcg),
             v_e_mg: get_float(v_e_mg),
             choline_mg: get_float(choline_mg),
             glycemix_index: get_float(glycemix_index)
           }) do
        {:ok, _product} -> IO.puts("Product #{id} - #{name} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! ProductAliases
  # # Seed product_aliases from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(DiabetesV1.ProductAliases.ProductAlias)

  def seed_product_aliases_data do
    IO.puts("Seeding product aliases...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/product_aliases.csv"))
    |> Enum.each(fn [
                      id,
                      product_name,
                      alias
                    ] ->
      case ProductAliases.create_product_alias(%{
             id: String.to_integer(id),
             product_id: get_id_by_name(Product, product_name),
             alias: String.trim(alias)
           }) do
        {:ok, _product_alias} -> IO.puts("Product Alias - #{alias} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! Ingredients
  # # Seed ingredients from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(DiabetesV1.Ingredients.Ingredient)

  def seed_ingredients_data do
    IO.puts("Seeding ingredients...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/ingredients.csv"))
    |> Enum.each(
      # in the csv, but ignoring recipe_num below
      fn [
           id,
           _recipe_num,
           product,
           ingredient,
           options,
           grams,
           included
         ] ->
        with {:ok, product_id} <- fetch_id_by_name(Product, product),
             {:ok, ingredient_id} <- fetch_id_by_name(Product, ingredient),
             {:ok, grams_float} <- get_float_tuple(grams) do
          attrs = %{
            id: String.to_integer(id),
            product_id: product_id,
            ingredient_id: ingredient_id,
            options: String.trim(options) |> default_nil_if_empty(),
            grams: grams_float,
            included: included == "yes"
          }

          case Ingredients.create_ingredient(attrs) do
            {:ok, _ingredient} ->
              IO.puts("Ingredient Number - #{id} created.")

            {:error, changeset} ->
              IO.puts("Failed to create ingredient with ID #{id}.")
              IO.inspect(changeset.errors)
          end
        else
          :error ->
            IO.puts("Invalid data for ingredient ID #{id}. Skipping...")

          error ->
            IO.inspect(error,
              label: "Unexpected Error for ingredient ID #{id}"
            )
        end
      end
    )
  end

  defp get_float_tuple(num) do
    {:ok, get_float(num)}
  end

  defp fetch_id_by_name(module, name) do
    case get_id_by_name(module, name) do
      nil -> {:error, "#{name} not found in #{module}"}
      id -> {:ok, id}
    end
  end

  defp default_nil_if_empty(""), do: nil
  defp default_nil_if_empty(value), do: value

  # def calculate_product_nutritional_content do
  #   # Batch update all recipes after seeding, limit to only products with ingredients
  #   # Using batching and transactions

  #   # wrap the updates in a transaction to ensure all updates succeed or none
  #   Repo.transaction(fn ->
  #     Repo.all(
  #       from p in DiabetesV1.Products.Product,
  #         # Include only products that have ingredients
  #         join: i in DiabetesV1.Ingredients.Ingredient,
  #         on: i.product_id == p.id,
  #         # Avoid processing the same product multiple times
  #         distinct: true,
  #         select: p.id
  #     )
  #     |> Enum.chunk_every(100)
  #     |> Enum.each(fn batch ->
  #       Enum.each(batch, &Products.update_recipe_nutrition(&1))
  #     end)
  #   end)
  # end

  def seed_test_data do
    # Insert or ensure the existence of specific products
    IO.puts("Creating Product - Test Product A")

    {:ok, _} =
      Products.create_product(%{
        name: "Test Product A",
        serving_g: 100,
        calories_kcal: 200,
        main_type_id: 1,
        sub_type_id: 1,
        category_id: 1
      })

    IO.puts("Creating Product - Test Product B")

    {:ok, _} =
      Products.create_product(%{
        name: "Test Product B",
        serving_g: 50,
        calories_kcal: 100,
        main_type_id: 1,
        sub_type_id: 1,
        category_id: 1
      })

    IO.puts("Creating Product - Test Product C")

    {:ok, _} =
      Products.create_product(%{
        name: "Test Product C",
        serving_g: 80,
        calories_kcal: 150,
        main_type_id: 1,
        sub_type_id: 1,
        category_id: 1
      })

    IO.puts("Creating Product - Test Product D")

    {:ok, _} =
      Products.create_product(%{
        name: "Test Product D",
        serving_g: 60,
        calories_kcal: 50,
        main_type_id: 1,
        sub_type_id: 1,
        category_id: 1
      })

    # Insert product aliases
    IO.puts("Creating Alias - Alias A for Test Product A")

    {:ok, _} =
      ProductAliases.create_product_alias(%{
        product_id: get_id_by_name(Products.Product, "Test Product A"),
        alias: "Alias A"
      })

    # Insert ingredients
    IO.puts("Adding Ingredient Test Product A for product Test Product B")

    {:ok, _} =
      Ingredients.create_ingredient(%{
        product_id: get_id_by_name(Products.Product, "Test Product B"),
        ingredient_id: get_id_by_name(Products.Product, "Test Product A"),
        included: true,
        grams: 20
      })

    IO.puts("Adding Ingredient Test Product D for product Test Product B")

    {:ok, _} =
      Ingredients.create_ingredient(%{
        product_id: get_id_by_name(Products.Product, "Test Product B"),
        ingredient_id: get_id_by_name(Products.Product, "Test Product D"),
        included: true,
        grams: 10
      })

    IO.puts("Adding Ingredient Alias A for product Test Product C")

    {:ok, _} =
      Ingredients.create_ingredient(%{
        product_id: get_id_by_name(Products.Product, "Test Product C"),
        ingredient_id: get_id_by_name(Products.Product, "Alias A"),
        included: true,
        grams: 40
      })

    IO.puts("Adding Ingredient Test Product D for product Test Product C")

    {:ok, _} =
      Ingredients.create_ingredient(%{
        product_id: get_id_by_name(Products.Product, "Test Product C"),
        ingredient_id: get_id_by_name(Products.Product, "Test Product D"),
        included: true,
        grams: 20
      })
  end

  def run_update_test do
    # This runs update_recipe_nutrition for Test Product B which uses Test Product A as an ingredient
    # and Test Product C which uses an Alias for Test Product A as an ingredient.

    # It will print out the details of the three test products after updating their nutritional values

    # Then it will delete the test products, aliases and ingredients

    # Fetch IDs for the recipes
    recipe_ids = [
      get_id_by_name(DiabetesV1.Products.Product, "Test Product B"),
      get_id_by_name(DiabetesV1.Products.Product, "Test Product C")
    ]

    # Debug: Check if recipe_ids is correctly populated
    # IO.inspect(recipe_ids, label: "Recipe IDs")

    # Update each recipe's nutrition
    Enum.each(recipe_ids, fn id ->
      IO.inspect(id, label: "Updating recipe nutrition for ID")
      Products.update_recipe_nutrition(id)
    end)

    # Debug: Ensure recipe_ids is a list of integers before query
    # IO.inspect(Enum.all?(recipe_ids, &is_integer/1), label: "Are all recipe_ids integers?")

    # Query updated product details
    updated_products =
      Repo.all(
        from(
          p in DiabetesV1.Products.Product,
          # Interpolate recipe_ids into the query
          where: p.id in ^recipe_ids,
          select: %{name: p.name, calories_kcal: p.calories_kcal}
        )
      )

    # Debug: Inspect the results
    IO.inspect(updated_products, label: "Updated Products")

    # ! Expected Output

    # [
    #   %{name: "Test Product B", calories: 73.33},
    #   %{name: "Test Product C", calories: 236.67}
    # ]
  end

  def delete_test_data do
    # Fetch IDs for the recipes
    recipe_ids = [
      get_id_by_name(DiabetesV1.Products.Product, "Test Product B"),
      get_id_by_name(DiabetesV1.Products.Product, "Test Product C")
    ]

    IO.puts("Deleting Products")

    Repo.delete_all(
      from p in DiabetesV1.Products.Product,
        where: p.name in ["Test Product A", "Test Product B", "Test Product C", "Test Product D"]
    )

    IO.puts("Deleting Product Aliases")

    Repo.delete_all(
      from a in DiabetesV1.ProductAliases.ProductAlias, where: a.alias in ["Alias A"]
    )

    IO.puts("Deleting Ingredients")

    Repo.delete_all(
      from i in DiabetesV1.Ingredients.Ingredient, where: i.product_id in ^recipe_ids
    )
  end

  def seed_weight_descriptions_for_ingredients_data do
    IO.puts("Adding Weight Descriptions to ingredients...")

    NimbleCSV.RFC4180.parse_stream(
      File.stream!("priv/repo/ingredients_with_weight_description.csv")
    )
    |> Enum.each(
      # in the csv, but ignoring recipe_num below
      fn [
           id,
           _recipe_num,
           _product,
           _ingredient,
           _options,
           _grams,
           _included,
           weight_description
         ] ->
        # Find the ingredient by ID
        case DiabetesV1.Repo.get(
               DiabetesV1.Ingredients.Ingredient,
               String.to_integer(id)
             ) do
          nil ->
            IO.puts("Ingredient ID #{id} not found. Skipping.")

          ingredient ->
            # Update the weight_description field
            ingredient
            |> Ecto.Changeset.change(weight_description: weight_description)
            |> DiabetesV1.Repo.update()
            |> case do
              {:ok, _updated_ingredient} ->
                IO.puts(
                  "Updated Ingredient ID #{id} with weight description: #{weight_description}"
                )

              {:error, changeset} ->
                IO.inspect(changeset.errors,
                  label: "Failed to update Ingredient ID #{id}"
                )
            end
        end
      end
    )
  end

  # ! Constants
  # # Seed constants from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(Constant)

  def seed_constants_data do
    IO.puts("Seeding constants...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/constants.csv"))
    |> Enum.each(fn [id, key, value, description, notes] ->
      case Constants.create_constant(%{
             id: String.to_integer(id),
             key: String.trim(key),
             value: get_float(value),
             description: String.trim(description),
             notes: String.trim(notes)
           }) do
        {:ok, _constant} -> IO.puts("Constant #{key} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! Exercises
  # # Seed exercises from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(Exercise)

  def seed_exercises_data do
    IO.puts("Seeding exercises...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/exercises.csv"))
    |> Enum.each(fn [id, type, intensity, met, description] ->
      case Exercises.create_exercise(%{
             id: String.to_integer(id),
             type: String.trim(type),
             intensity: String.trim(intensity),
             met: get_float(met),
             description: String.trim(description)
           }) do
        {:ok, _exercise} -> IO.puts("Exercise #{type} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  defp parse_date(date_string) do
    [day, month, year] = String.split(date_string, "/")

    # Add "20" to the year if it's only 2 digits
    year =
      if String.length(year) == 2 do
        "20" <> year
      else
        year
      end

    case Date.new(String.to_integer(year), String.to_integer(month), String.to_integer(day)) do
      {:ok, date} -> date
      {:error, _reason} -> raise "Invalid date: #{date_string}"
    end
  end

  # ! PeriodDates
  # # Seed period_dates from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(PeriodDate)

  def seed_period_dates_data do
    IO.puts("Seeding period dates...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/period_dates.csv"))
    |> Enum.each(fn [id, user_id, start_date] ->
      case PeriodDates.create_period_date(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             start_date: parse_date(String.trim(start_date))
           }) do
        {:ok, _period_date} -> IO.puts("Period Date #{start_date} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! BodyWeights
  # # Seed body_weights from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(BodyWeight)

  def seed_body_weights_data do
    IO.puts("Seeding body weights...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/body_weights.csv"))
    |> Enum.each(fn [id, user_id, reading_date, weight_kg] ->
      case BodyWeights.create_body_weight(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             reading_date: parse_date(String.trim(reading_date)),
             weight_kg: get_float(String.trim(weight_kg))
           }) do
        {:ok, _body_weight} -> IO.puts("Body Weight #{weight_kg} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! BasalChanges
  # # Seed basal_changes from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(BasalChange)

  def seed_basal_changes_data do
    IO.puts("Seeding basal changes...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/basal_changes.csv"))
    |> Enum.each(fn [id, user_id, change_date, doses, reason] ->
      case BasalChanges.create_basal_change(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             change_date: parse_date(String.trim(change_date)),
             doses: String.to_integer(String.trim(doses)),
             reason: String.trim(reason)
           }) do
        {:ok, _basal_change} -> IO.puts("Basal Change #{doses} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! DoseFactorChanges
  # # Seed dose_factor_changes from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(DoseFactorChange)

  def seed_dose_factor_changes_data do
    IO.puts("Seeding dose factor changes...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/dose_factor_changes.csv"))
    |> Enum.each(fn [id, user_id, change_date, isf_value, icr_value, notes] ->
      case DoseFactorChanges.create_dose_factor_change(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             change_date: parse_date(String.trim(change_date)),
             isf_value: get_float(String.trim(isf_value)),
             icr_value: get_float(String.trim(icr_value)),
             notes: String.trim(notes)
           }) do
        {:ok, _dose_factor_change} -> IO.puts("Dose Factor Change #{isf_value} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # helper function to deal with nil integer fields
  defp parse_integer(str, default \\ 0)
  defp parse_integer(nil, default), do: default
  defp parse_integer("", default), do: default
  defp parse_integer(str, _default), do: String.to_integer(str)

  # ! InsulinPurchases
  # # Seed insulin_purchases from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(InsulinPurchase)

  def seed_insulin_purchases_data do
    IO.puts("Seeding insulin purchases...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/insulin_purchases.csv"))
    |> Enum.each(fn [
                      id,
                      user_id,
                      change_date,
                      fiasp_total_doses,
                      fiasp_initial_doses_used,
                      tresiba_total_doses,
                      tresiba_initial_doses_used,
                      comments
                    ] ->
      case InsulinPurchases.create_insulin_purchase(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             change_date: parse_date(String.trim(change_date)),
             fiasp_total_doses: parse_integer(fiasp_total_doses),
             fiasp_initial_doses_used: parse_integer(fiasp_initial_doses_used),
             tresiba_total_doses: parse_integer(tresiba_total_doses),
             tresiba_initial_doses_used: parse_integer(tresiba_initial_doses_used),
             comments: String.trim(comments)
           }) do
        {:ok, _insulin_purchase} -> IO.puts("Insulin_Purchase #{fiasp_total_doses} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end
end

# MySeeder.seed_product_main_types_data()
# MySeeder.seed_product_sub_types_data()
# MySeeder.seed_product_categories_data()
# MySeeder.seed_product_data()
# MySeeder.seed_product_aliases_data()
# MySeeder.seed_ingredients_data()
# MySeeder.seed_test_data()
# MySeeder.run_update_test()
# MySeeder.delete_test_data()
# run calculate_product_nutritional_content once seeding is successfully done
# DiabetesV1.Products.calculate_product_nutritional_content()
# MySeeder.seed_weight_descriptions_for_ingredients_data()
# MySeeder.seed_constants_data()
# MySeeder.seed_exercises_data()
# MySeeder.seed_period_dates_data()
# MySeeder.seed_body_weights_data()
# MySeeder.seed_basal_changes_data()
# MySeeder.seed_dose_factor_changes_data()
MySeeder.seed_insulin_purchases_data()
