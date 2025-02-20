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
  alias DiabetesV1.SensorChanges
  alias DiabetesV1.Days
  alias DiabetesV1.Times
  alias DiabetesV1.Meals

  import Ecto.Query

  # ! ProductMainTypes
  # Seed product_main_types from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(ProductMainTypes.ProductMainType)

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
  # Repo.delete_all(ProductSubTypes.ProductSubType)

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
  # Repo.delete_all(ProductCategories.ProductCategory)

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
  # Repo.delete_all(Products.Product)

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
  # Repo.delete_all(Constants.Constant)

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
  # Repo.delete_all(Exercises.Exercise)

  def seed_exercises_data(file_path) do
    IO.puts("Seeding exercises...")

    NimbleCSV.RFC4180.parse_stream(File.stream!(file_path))
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
  # Repo.delete_all(PeriodDates.PeriodDate)

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
  # Repo.delete_all(BodyWeights.BodyWeight)

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
  # Repo.delete_all(BasalChanges.BasalChange)

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
  # Repo.delete_all(DoseFactorChanges.DoseFactorChange)

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
  # Repo.delete_all(InsulinPurchases.InsulinPurchase)

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

  # ! SensorChanges
  # # Seed sensor_changes from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(SensorChanges.SensorChange)

  def seed_sensor_changes_data do
    IO.puts("Seeding sensor_changes...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/sensor_changes.csv"))
    |> Enum.each(fn [id, user_id, start_date, num_days, comments] ->
      case SensorChanges.create_sensor_change(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             start_date: parse_date(String.trim(start_date)),
             num_days: String.to_integer(num_days),
             comments: String.trim(comments)
           }) do
        {:ok, _sensor_change} -> IO.puts("Sensor Change #{num_days} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # helper function to deal with time fields and nil time fields
  defp parse_time(time_string, default \\ nil)
  defp parse_time(nil, default), do: default
  defp parse_time("", default), do: default

  defp parse_time(time_string, _default) do
    [time_part, am_pm] = String.split(time_string, " ")
    [hour, minute] = String.split(time_part, ":") |> Enum.map(&String.to_integer/1)

    hour =
      cond do
        am_pm == "PM" and hour < 12 -> hour + 12
        am_pm == "AM" and hour == 12 -> 0
        true -> hour
      end

    {:ok, time} = Time.new(hour, minute, 0)
    time
  end

  # ! Days
  # # Seed days from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(Days.Day)

  def seed_days_data do
    IO.puts("Seeding days...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/days.csv"))
    |> Enum.each(fn [
                      id,
                      user_id,
                      _user_day_num,
                      day_date,
                      basal,
                      icr_fixed,
                      isf_fixed,
                      fiasp_left,
                      tresiba_left,
                      sensor_day,
                      _body_weight,
                      _period_day,
                      notes
                    ] ->
      case Days.create_day(%{
             id: String.to_integer(id),
             user_id: String.to_integer(user_id),
             day_date: parse_date(String.trim(day_date)),
             basal: parse_integer(basal),
             icr_fixed: get_float(icr_fixed),
             isf_fixed: get_float(isf_fixed),
             fiasp_left: parse_integer(fiasp_left),
             tresiba_left: parse_integer(tresiba_left),
             sensor_day: String.to_integer(sensor_day),
             notes: String.trim(notes)
           }) do
        {:ok, _day} -> IO.puts("Day #{id} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! Times
  # # Seed times from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(Times.Time)

  def seed_times_data do
    IO.puts("Seeding times...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/times.csv"))
    |> Enum.each(fn [
                      id,
                      day_id,
                      _date,
                      event_time,
                      blood_sugar,
                      meal_num,
                      dose_time,
                      doses,
                      _split_dose_time,
                      _split_doses,
                      meal_time,
                      _two_hrs_bs,
                      exercise_id,
                      exercise_start,
                      exercise_end,
                      event_type,
                      dose_type
                    ] ->
      case Times.create_time(%{
             id: String.to_integer(id),
             day_id: String.to_integer(day_id),
             event_time: parse_time(event_time),
             blood_sugar: String.to_integer(blood_sugar),
             meal_num: parse_integer(meal_num),
             dose_time: parse_time(dose_time),
             doses: parse_integer(doses),
             meal_time: parse_time(meal_time),
             exercise_id: parse_integer(String.trim(exercise_id)),
             exercise_start: parse_time(exercise_start),
             exercise_end: parse_time(exercise_end),
             event_type: String.trim(event_type),
             dose_type: String.trim(dose_type)
           }) do
        {:ok, _time} -> IO.puts("Time #{event_time} created.")
        {:error, changeset} -> IO.inspect(changeset.errors)
      end
    end)
  end

  # ! Meals
  # # Seed meals from a CSV file

  # ! To delete all data uncomment following line
  # Repo.delete_all(Meals.Meal)

  def seed_meals_data do
    IO.puts("Seeding meals...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/meals.csv"))
    |> Enum.each(fn [id, time_id, _day_num, _date, meal_num, food, qty, weight] ->
      with {:ok, product_id} <- fetch_id_by_name(Product, food) do
        attrs = %{
          id: String.to_integer(id),
          time_id: String.to_integer(time_id),
          meal_num: String.to_integer(meal_num),
          product_id: product_id,
          qty: get_float(qty),
          weight: get_float(weight)
        }

        case Meals.create_meal(attrs) do
          {:ok, _meal} -> IO.puts("Meal #{food} created.")
          {:error, changeset} -> IO.inspect(changeset.errors)
        end
      else
        :error -> IO.puts("Invalid data for meal ID #{id}. Skipping...")
        error -> IO.inspect(error, label: "Unexpected Error for meal ID #{id}")
      end
    end)
  end

  def add_event_type_for_times_data do
    IO.puts("Adding Event Types to times...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/times-with-event-type.csv"))
    |> Enum.each(
      # in the csv, but ignoring all fields except id and event_type below
      fn [
           id,
           _day_id,
           _date,
           _event_time,
           _blood_sugar,
           _meal_num,
           _dose_time,
           _doses,
           _split_dose_time,
           _split_doses,
           _meal_time,
           _two_hrs_bs,
           _exercise_id,
           _exercise_start,
           _exercise_end,
           event_type
         ] ->
        # Find the ingredient by ID
        case DiabetesV1.Repo.get(
               DiabetesV1.Times.Time,
               String.to_integer(id)
             ) do
          nil ->
            IO.puts("Time ID #{id} not found. Skipping.")

          time ->
            # Update the event_type field
            time
            |> Ecto.Changeset.change(event_type: event_type)
            |> DiabetesV1.Repo.update()
            |> case do
              {:ok, _updated_time} ->
                IO.puts("Updated Time ID #{id} with event type: #{event_type}")

              {:error, changeset} ->
                IO.inspect(changeset.errors,
                  label: "Failed to update Time ID #{id}"
                )
            end
        end
      end
    )
  end

  defp get_next_id() do
    case Repo.one(from t in DiabetesV1.Times.Time, select: max(t.id)) do
      # Start with 1 if the table is empty
      nil -> 1
      max_id -> max_id + 1
    end
  end

  defp get_day_id(day_id, event_time, split_dose_time) do
    if event_time > split_dose_time do
      day_id + 1
    else
      day_id
    end
  end

  def seed_times_data_adding_split_doses do
    IO.puts("Seeding times adding split doses...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/times.csv"))
    |> Enum.each(fn [
                      _id,
                      day_id,
                      _date,
                      event_time,
                      _blood_sugar,
                      _meal_num,
                      _dose_time,
                      _doses,
                      split_dose_time,
                      split_doses,
                      _meal_time,
                      _two_hrs_bs,
                      _exercise_id,
                      _exercise_start,
                      _exercise_end,
                      _event_type,
                      _dose_type
                    ] ->
      if split_dose_time != "" and split_doses != "" do
        # Parse values
        day_id = String.to_integer(day_id)
        event_time = parse_time(event_time)
        split_dose_time = parse_time(split_dose_time)
        split_doses = String.to_integer(split_doses)

        # Get correct day_id for split_dose_time
        day_id = get_day_id(day_id, event_time, split_dose_time)

        # Check if a record with the same day_id + event_time exists
        existing_record =
          DiabetesV1.Times.Time
          |> where([t], t.day_id == ^day_id and t.event_time == ^split_dose_time)
          |> Repo.one()

        if existing_record do
          # Update the existing record
          changeset =
            existing_record
            |> Ecto.Changeset.cast(
              %{
                dose_time: split_dose_time,
                doses: split_doses,
                event_type: "split dose",
                dose_type: "split"
              },
              [:dose_time, :doses, :event_type, :dose_type]
            )

          case Repo.update(changeset) do
            {:ok, _updated_record} ->
              IO.puts("Updated existing split dose for #{split_dose_time}.")

            {:error, changeset} ->
              IO.inspect(changeset.errors)
          end
        else
          # Insert a new record
          case DiabetesV1.Times.create_time(%{
                 id: get_next_id(),
                 day_id: day_id,
                 event_time: split_dose_time,
                 blood_sugar: nil,
                 meal_num: nil,
                 dose_time: split_dose_time,
                 doses: split_doses,
                 meal_time: nil,
                 exercise_id: nil,
                 exercise_start: nil,
                 exercise_end: nil,
                 event_type: "split dose",
                 dose_type: "split"
               }) do
            {:ok, _time} -> IO.puts("Created new split dose for #{split_dose_time}.")
            {:error, changeset} -> IO.inspect(changeset.errors)
          end
        end
      end
    end)
  end

  # def insert_time_test_data(file_path) do
  #   file_path
  #   |> File.stream!()
  #   # Skip header row
  #   |> Stream.drop(1)
  #   |> Stream.map(&parse_csv_row/1)
  #   |> Enum.each(&Repo.insert!/1)
  # end

  # defp parse_csv_row(row) do
  #   [
  #     id,
  #     day_id,
  #     date,
  #     event_time,
  #     blood_sugar,
  #     meal_num,
  #     dose_time,
  #     doses,
  #     split_dose_time,
  #     split_doses,
  #     meal_time,
  #     two_hrs_bs,
  #     exercise_id,
  #     exercise_start,
  #     exercise_end,
  #     event_type,
  #     dose_type
  #   ] =
  #     row |> String.trim() |> String.split(",")

  #   %DiabetesV1.Times.Time{
  #     id: String.to_integer(id),
  #     day_id: String.to_integer(day_id),
  #     date: new_parse_date(date),
  #     event_time: new_parse_time(event_time),
  #     blood_sugar: new_parse_integer(blood_sugar),
  #     meal_num: new_parse_integer(meal_num),
  #     dose_time: new_parse_time(dose_time),
  #     doses: new_parse_integer(doses),
  #     split_dose_time: new_parse_time(split_dose_time),
  #     split_doses: new_parse_integer(split_doses),
  #     meal_time: new_parse_time(meal_time),
  #     two_hrs_bs: new_parse_integer(two_hrs_bs),
  #     exercise_id: new_parse_integer(exercise_id),
  #     exercise_start: new_parse_time(exercise_start),
  #     exercise_end: new_parse_time(exercise_end),
  #     event_type: new_parse_string(event_type),
  #     dose_type: new_parse_string(dose_type)
  #   }
  # end

  defp new_parse_date(date) when date in ["", nil], do: nil
  defp new_parse_date(date), do: Date.from_iso8601!("20" <> String.replace(date, "/", "-"))

  defp new_parse_time(time) when time in ["", nil], do: nil
  defp new_parse_time(time), do: Time.from_iso8601!(convert_to_24hr(time))

  defp new_parse_integer(value) when value in ["", nil], do: nil
  defp new_parse_integer(value), do: String.to_integer(value)

  defp new_parse_string(value) when value in ["", nil], do: nil
  defp new_parse_string(value), do: String.trim(value)

  defp convert_to_24hr(time) do
    case Timex.parse(time, "%I:%M %p", :strftime) do
      {:ok, datetime} -> Timex.format!(datetime, "%H:%M:%S", :strftime)
      # Fallback to default if parsing fails
      {:error, _} -> "00:00:00"
    end
  end

  def delete_times_test_data do
    # Delete records with id >= 15112
    from(t in Time, where: t.id >= 15112)
    |> Repo.delete_all()
  end

  defp log_message_to_file(filename, message) do
    File.write!(filename, "#{message}\n", [:append])
  end

  defp my_puts_exercise(message) do
    IO.puts(message)
    log_message_to_file("priv/repo/exercise_log.txt", message)
  end

  def seed_times_data_separating_exercises(csv_file) do
    my_puts_exercise("Seeding times separating exercises...")

    # Parse CSV and iterate through each row
    NimbleCSV.RFC4180.parse_stream(File.stream!(csv_file))
    |> Enum.each(fn [
                      id,
                      day_id,
                      _date,
                      event_time,
                      _blood_sugar,
                      meal_num,
                      _dose_time,
                      doses,
                      _split_dose_time,
                      _split_doses,
                      meal_time,
                      _two_hrs_bs,
                      exercise_id,
                      exercise_start,
                      exercise_end,
                      event_type,
                      dose_type
                    ] ->
      # Process all records with exercises

      if exercise_id != "" do
        my_puts_exercise("Processing record id. #{id}")
        # Parse values
        id = String.to_integer(id || "0")
        day_id = String.to_integer(day_id || "0")
        event_time = parse_time(event_time || "00:00:00")
        meal_num = String.to_integer(meal_num || "0")
        doses = String.to_integer(doses || "0")
        saved_exercise_id = String.to_integer(exercise_id || "0")
        exercise_start = parse_time(exercise_start || "00:00:00")
        exercise_end = parse_time(exercise_end || "00:00:00")
        exercise_mins = Time.diff(exercise_end, exercise_start, :minute)

        # Helper: Update a record
        update_record = fn record, changes ->
          record
          |> Ecto.Changeset.cast(changes, Map.keys(changes))
          |> Repo.update()
        end

        # Helper: Create a new record
        create_new_record = fn ->
          DiabetesV1.Times.create_time(%{
            id: get_next_id(),
            day_id: day_id,
            event_time: exercise_start,
            event_type: "exercise",
            dose_type: nil,
            blood_sugar: nil,
            meal_num: nil,
            dose_time: nil,
            doses: nil,
            meal_time: nil,
            exercise_id: saved_exercise_id,
            exercise_mins: exercise_mins
          })
        end

        cond do
          # Case 1: Use same record, ie change it to an exercise record
          meal_num == 0 and doses == 0 and event_time == exercise_start ->
            my_puts_exercise("Case 1")
            my_puts_exercise("Case 1: Updating original record id #{id} for exercise start.")

            update_record.(
              %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
              %{
                exercise_mins: exercise_mins,
                event_type: "exercise",
                exercise_start: nil,
                exercise_end: nil
              }
            )

          # Case 2: Find another record for exercise info
          meal_num == 0 and doses == 0 and event_time != exercise_start ->
            my_puts_exercise("Case 2")

            existing_record =
              DiabetesV1.Times.Time
              |> where([t], t.day_id == ^day_id and t.event_time == ^exercise_start)
              |> Repo.one()

            if existing_record do
              my_puts_exercise(
                "Case 2. Updating original record for id #{id} to remove exercise ..."
              )

              # Update original record to remove exercise info
              update_record.(
                %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
                %{
                  event_type: "reading",
                  exercise_id: nil,
                  exercise_start: nil,
                  exercise_end: nil
                }
              )

              my_puts_exercise(
                "Case 2. Updating the exising record for id #{id} to add exercise ..."
              )

              # Update existing record to add exercise info
              update_record.(existing_record, %{
                event_type: "exercise",
                exercise_id: saved_exercise_id,
                exercise_mins: exercise_mins
              })
            else
              # Update original record to remove exercise info
              my_puts_exercise(
                "Case 2. Updating original record for id #{id} to remove exercise ..."
              )

              update_record.(
                %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
                %{
                  event_type: "reading",
                  exercise_id: nil,
                  exercise_start: nil,
                  exercise_end: nil
                }
              )

              my_puts_exercise(
                "Case 2. No existing record found; creating a new one for id #{id} to add exercise..."
              )

              # Create new record to have the exercise info
              create_new_record.()
            end

          # Case 4 & 5: Record includes an exercise and a meal_num or doses
          # so remove the exercise info and put it in a separate record
          meal_num > 0 or doses > 0 ->
            my_puts_exercise("Case 4 or 5: Record includes meal_num or doses.  id #{id} ")

            existing_record =
              DiabetesV1.Times.Time
              |> where([t], t.day_id == ^day_id and t.event_time == ^exercise_start)
              |> Repo.one()

            event_type =
              cond do
                meal_num > 0 -> "meal"
                doses > 0 -> "dose"
                true -> "reading"
              end

            if existing_record do
              my_puts_exercise(
                "Case 4 & 5. Updating original record for id #{id} to remove exercise ..."
              )

              # Update original record to remove exercise info
              update_record.(
                %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
                %{
                  event_type: event_type,
                  exercise_id: nil,
                  exercise_start: nil,
                  exercise_end: nil
                }
              )

              my_puts_exercise(
                "Case 4 & 5. Updating the exising record for id #{id} to add exercise ..."
              )

              # Update existing record to add exercise info
              update_record.(existing_record, %{
                event_type: "exercise",
                exercise_id: saved_exercise_id,
                exercise_mins: exercise_mins
              })
            else
              my_puts_exercise(
                "Case 4 & 5. Updating original record for id #{id} to remove exercise ..."
              )

              # Update original record to remove exercise info
              update_record.(
                %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
                %{
                  event_type: event_type,
                  exercise_id: nil,
                  exercise_start: nil,
                  exercise_end: nil
                }
              )

              # Create new record to have the exercise info
              my_puts_exercise(
                "Case 4 & 5 No existing record found; creating a new one for id #{id} to add exercise..."
              )

              create_new_record.()
            end
        end
      end
    end)
  end

  def seed_times_data_separating_exercises_in_transaction(csv_file) do
    Repo.transaction(fn ->
      seed_times_data_separating_exercises(csv_file)
    end)
  end

  defp adjust_time(time, offset_minutes) do
    NaiveDateTime.from_iso8601!(time)
    |> NaiveDateTime.add(offset_minutes * 60, :second)
    |> NaiveDateTime.to_iso8601()
  end

  defp my_puts_meal(message) do
    IO.puts(message)
    log_message_to_file("priv/repo/meal_log.txt", message)
  end

  # def seed_times_data_separating_meals(csv_file) do
  #   my_puts_meal("Seeding times separating meals...")

  #   # Parse CSV and iterate through each row
  #   NimbleCSV.RFC4180.parse_stream(File.stream!(csv_file))
  #   |> Enum.each(fn [
  #                     id,
  #                     day_id,
  #                     _date,
  #                     event_time,
  #                     blood_sugar,
  #                     meal_num,
  #                     dose_time,
  #                     doses,
  #                     _split_dose_time,
  #                     _split_doses,
  #                     meal_time,
  #                     _two_hrs_bs,
  #                     _exercise_id,
  #                     _exercise_start,
  #                     _exercise_end,
  #                     event_type,
  #                     dose_type
  #                   ] ->
  #     if meal_num != "" do
  #       my_puts_meal("Processing record id. #{id}")
  #       # Parse values
  #       id = String.to_integer(id || "0")
  #       day_id = String.to_integer(day_id || "0")
  #       event_time = parse_time(event_time || "00:00:00")
  #       meal_num = String.to_integer(meal_num || "0")
  #       dose_time = parse_time(dose_time || "00:00:00")
  #       doses = String.to_integer(doses || "0")
  #       meal_time = parse_time(meal_time || "00:00:00")
  #       event_type = String.trim(event_type)
  #       dose_type = String.trim(dose_type)
  #       new_meal_id = nil
  #       saved_event_time = event_time

  #       # Helper: Update a record
  #       update_record = fn record, changes ->
  #         record
  #         |> Ecto.Changeset.cast(changes, Map.keys(changes))
  #         |> Repo.update()
  #       end

  #       # Helper: Create a new dose record, pass event_time in as new_dose_time
  #       # pass dose_type in as new_dose_type, and pass blood_sugar in as reading
  #       create_new_dose_record = fn new_dose_time, new_dose_type.reading ->
  #         DiabetesV1.Times.create_time(%{
  #           id: get_next_id(),
  #           day_id: day_id,
  #           event_time: new_dose_time,
  #           event_type: "dose",
  #           dose_type: new_dose_type,
  #           blood_sugar: reading,
  #           meal_num: nil,
  #           from_meal: id,
  #           dose_time: nil,
  #           doses: doses,
  #           meal_time: nil,
  #           exercise_id: nil,
  #           exercise_mins: nil
  #         })
  #       end

  #       # Helper: Create a new reading record, pass event_time in as new_reading_time
  #       # pass blood_sugar in as reading
  #       create_new_reading_record = fn new_reading_time, reading ->
  #         DiabetesV1.Times.create_time(%{
  #           id: get_next_id(),
  #           day_id: day_id,
  #           event_time: new_reading_time,
  #           event_type: "reading",
  #           dose_type: nil,
  #           blood_sugar: reading,
  #           meal_num: nil,
  #           from_meal: nil,
  #           dose_time: nil,
  #           doses: doses,
  #           meal_time: nil,
  #           exercise_id: nil,
  #           exercise_mins: nil
  #         })
  #       end

  #       cond do
  #         # Case 1: Update to meal, add dose
  #         event_time == dose_time and dose_time == meal_time ->
  #           my_puts_meal("Case 1: id = #{id} update to meal, add dose")

  #           # Update original record to be a meal and remove dose info and meal_time
  #           update_record.(
  #             %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #             %{
  #               dose_time: nil,
  #               doses: nil,
  #               meal_time: nil,
  #               event_type: "meal"
  #             }
  #           )

  #           # Check and update/create the dose record
  #           # Is there already a record at event time - 1?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^adjust_time(event_time, 1)
  #                ) do
  #             nil ->
  #               my_puts_meal(
  #                 "No existing record at event_time + 1; creating a new dose record for id #{id} ..."
  #               )

  #               create_new_dose_record.(adjust_time(event_time, 1), "meal", nil)

  #             existing ->
  #               my_puts_meal("Updating existing record to make it a dose for id #{id} ...")

  #               update_record.(existing, %{
  #                 event_type: "dose",
  #                 dose_type: "meal",
  #                 doses: doses,
  #                 from_meal: id
  #               })
  #           end

  #         # Case 2: Update original record as meal, add dose record
  #         event_time == dose_time and dose_time != meal_time ->
  #           my_puts_meal("Case 2: id = #{id} update original record to meal, add dose")

  #           # Update original record to meal at meal_time and remove dose info and meal_time and BS
  #           # Is there already a record at meal time?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^meal_time
  #                ) do
  #             nil ->
  #               # No records at meal_time so change original record event_time to meal_time
  #               my_puts_meal(
  #                 "Update original record to make it a meal for id #{id} at meal_time ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: meal_time,
  #                   blood_sugar: nil
  #                 }
  #               )

  #             existing ->
  #               # A record exists at meal_time so change original record event_time to meal_time + 1
  #               my_puts_meal(
  #                 "Update original record to make it a meal for id #{id} at meal_time + 1 min ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: adjust_time(meal_time, 1),
  #                   blood_sugar: nil
  #                 }
  #               )
  #           end

  #           # Add the dose record (add the blood_sugar)
  #           create_new_dose_record.(dose_time, "meal", blood_sugar)

  #         # Case 3: Update original to meal, add/update dose, add reading
  #         event_time != dose_time and dose_time == meal_time ->
  #           my_puts_meal(
  #             "Case 3 id = #{id} update original record to meal, add dose, add reading"
  #           )

  #           # Update original record for meal at meal_time or meal_time + 1
  #           # and remove dose info and meal_time and BS
  #           # Is there already a record at meal time?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^meal_time
  #                ) do
  #             nil ->
  #               my_puts_meal(
  #                 "Update original record to make it a meal for id #{id} at meal_time ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: meal_time,
  #                   blood_sugar: nil
  #                 }
  #               )

  #             existing ->
  #               my_puts_meal(
  #                 "Update original record at meal_time to make it a meal for id #{id} at meal_time + 1 min ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: adjust_time(meal_time, 1),
  #                   blood_sugar: nil
  #                 }
  #               )
  #           end

  #           # Update existing record/add new record for dose at meal_time - 1
  #           # Is there already a record at meal time - 1?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^adjust_time(meal_time, -1)
  #                ) do
  #             nil ->
  #               my_puts_meal("Add new record for the dose for id #{id} at meal_time - 1 ...")
  #               create_new_dose_record.(adjust_time(meal_time, -1), "meal", nil)

  #             existing ->
  #               my_puts_meal(
  #                 "Update existing record at meal_time - 1 min to make it a dose for id #{id}  ..."
  #               )

  #               update_record.(
  #                 existing,
  #                 %{
  #                   dose_time: nil,
  #                   doses: doses,
  #                   meal_time: nil,
  #                   event_type: "dose",
  #                   dose_type: "meal",
  #                   blood_sugar: nil
  #                 }
  #               )
  #           end

  #           # Create the reading record (add the blood_sugar)
  #           create_new_reading_record.(event_time, blood_sugar)

  #         # Case 4: Update to meal, add dose
  #         event_time == meal_time and event_time != dose_time ->
  #           my_puts_meal("Case 4 id = #{id} update to meal, add dose")

  #           new_meal_id = id

  #           # Update original record to be a meal and remove dose info
  #           update_record.(
  #             %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #             %{
  #               dose_time: nil,
  #               doses: nil,
  #               event_type: "meal"
  #             }
  #           )

  #           # Check and update/create the dose record
  #           # Is there already a record at dose time?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^dose_time
  #                ) do
  #             nil ->
  #               my_puts_meal(
  #                 "No existing record found; creating a new dose record for id #{id} ..."
  #               )

  #               create_new_dose_record.(dose_time, "meal")

  #             existing ->
  #               my_puts_meal("Updating existing record to make it a dose for id #{id} ...")

  #               update_record.(existing, %{
  #                 event_type: "dose",
  #                 dose_type: "meal",
  #                 doses: doses,
  #                 from_meal: new_meal_id
  #               })
  #           end

  #         # Case 5: Update to meal, add dose, add reading
  #         event_time != dose_time and event_time != meal_time and dose_time != meal_time ->
  #           my_puts_meal("Case 5 id = #{id} update to meal, add dose, add reading")

  #           # Update original record for meal at meal_time
  #           # and remove dose info and meal_time and BS
  #           # Is there already a record at meal time?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^meal_time
  #                ) do
  #             nil ->
  #               my_puts_meal(
  #                 "Update original record to make it a meal for id #{id} at meal_time ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: meal_time,
  #                   blood_sugar: nil
  #                 }
  #               )

  #             existing ->
  #               my_puts_meal(
  #                 "Update original record to make it a meal for id #{id} at meal_time + 1 min ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: adjust_time(meal_time, 1),
  #                   blood_sugar: nil
  #                 }
  #               )
  #           end

  #           # Update existing record/add new record for dose at dose
  #           # Is there already a record at dose time?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == dose_time
  #                ) do
  #             nil ->
  #               my_puts_meal("Add new record for the dose for id #{id} at dose_time ...")
  #               create_new_dose_record.(dose_time, "meal", nil)

  #             existing ->
  #               my_puts_meal("Update existing record to make it a dose for id #{id} at dose ...")

  #               update_record.(
  #                 existing,
  #                 %{
  #                   dose_time: nil,
  #                   doses: doses,
  #                   meal_time: nil,
  #                   event_type: "dose",
  #                   dose_type: "meal",
  #                   blood_sugar: nil
  #                 }
  #               )
  #           end

  #           # Create the reading record (add the blood_sugar)
  #           create_new_reading_record.(event_time, blood_sugar)

  #         # Case 6: Update to meal
  #         event_time == meal_time and doses == nil ->
  #           my_puts_meal("Case 6 id = #{id} update to meal")

  #           # Update original record to remove meal_time (event_time IS meal_time)
  #           update_record.(
  #             %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #             %{
  #               meal_time: nil
  #             }
  #           )

  #         # Case 7: Update to reading, add meal
  #         event_time != meal_time and doses == nil ->
  #           my_puts_meal("Case 7 id = #{id} update to reading, add meal")

  #           # Update original record for meal at meal_time or meal_time + 1
  #           # and remove dose info and meal_time and BS
  #           # Is there already a record at meal time?
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^meal_time
  #                ) do
  #             nil ->
  #               my_puts_meal(
  #                 "Update original record to make it a meal for id #{id} at meal_time ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: meal_time,
  #                   blood_sugar: nil
  #                 }
  #               )

  #             existing ->
  #               my_puts_meal(
  #                 "Update original record at meal_time to make it a meal for id #{id} at meal_time + 1 min ..."
  #               )

  #               update_record.(
  #                 %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #                 %{
  #                   dose_time: nil,
  #                   doses: nil,
  #                   meal_time: nil,
  #                   event_type: "meal",
  #                   event_time: adjust_time(meal_time, 1),
  #                   blood_sugar: nil
  #                 }
  #               )
  #           end

  #           # Create the reading record (add the blood_sugar)
  #           create_new_reading_record.(event_time, blood_sugar)
  #       end
  #     else
  #       # Case 8: Update to dose
  #       if(event_time == dose_time and meal_time == nil) do
  #         my_puts_meal("Case 8 id = #{id} update to dose")

  #         # Update original record to remove dose_time (event_time IS dose_time)
  #         update_record.(
  #           %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #           %{
  #             dose_time: nil,
  #             dose_type: "boost"
  #           }
  #         )
  #       end

  #       # Case 9: Update to reading, add dose
  #       if event_time != dose_time and meal_time == nil do
  #         my_puts_meal("Case 9 id = #{id} update to reading, add dose")

  #         # Update original record to be a reading and remove dose info
  #         update_record.(
  #           %DiabetesV1.Times.Time{id: id, day_id: day_id, event_time: event_time},
  #           %{
  #             doses: nil,
  #             dose_time: nil,
  #             event_type: "reading"
  #           }
  #         )

  #         # Check and update/create the dose record
  #         # Is there already a record at dose time?
  #         new_dose_id =
  #           case Repo.one(
  #                  from t in DiabetesV1.Times.Time,
  #                    where: t.day_id == ^day_id and t.event_time == ^dose_time
  #                ) do
  #             nil ->
  #               my_puts_meal(
  #                 "No existing record found; creating a new dose record for id #{id} ..."
  #               )

  #               {:ok, dose_record} = create_new_dose_record.(dose_time, "boost")
  #               dose_record.id

  #             existing ->
  #               my_puts_meal("Updating existing record to make it a dose for id #{id} ...")

  #               update_record.(existing, %{event_type: "dose", doses: doses, dose_type: "boost"})

  #               existing.id
  #           end
  #       end
  #     end
  #   end)
  # end

  # def seed_times_data_separating_meals_in_transaction(csv_file) do
  #   Repo.transaction(fn ->
  #     seed_times_data_separating_meals(csv_file)
  #   end)
  # end

  def seed_times_exercise_id do
    IO.puts("Updating times with exercise_id...")

    NimbleCSV.RFC4180.parse_stream(File.stream!("priv/repo/times.csv"))
    |> Enum.each(fn [
                      id,
                      _day_id,
                      _date,
                      _event_time,
                      _blood_sugar,
                      _meal_num,
                      _dose_time,
                      _doses,
                      _split_dose_time,
                      _split_doses,
                      _meal_time,
                      _two_hrs_bs,
                      exercise_id,
                      exercise_start,
                      _exercise_end,
                      _event_type,
                      _dose_type
                    ] ->
      # Only update records where exercise_start is present
      if not is_nil(exercise_start) and exercise_start != "" do
        parsed_exercise_id = parse_integer(String.trim(exercise_id))

        # Debug: Check if exercise_id is parsed correctly
        IO.inspect(exercise_id, label: "Raw Exercise ID from CSV")
        IO.inspect(parsed_exercise_id, label: "Parsed Exercise ID")

        case Times.get_time!(String.to_integer(id)) do
          %Times.Time{} = time ->
            # Debugging step
            IO.inspect(time, label: "Fetched time")

            case Times.update_time(time, %{exercise_id: parsed_exercise_id}) do
              {:ok, updated_time} ->
                # Debug: Verify the updated record
                IO.inspect(updated_time, label: "Updated Time Record")
                IO.puts("Updated time #{id} with exercise_id #{parsed_exercise_id}.")

              {:error, changeset} ->
                IO.puts("Failed to update time ID #{id}")
                IO.inspect(changeset.errors, label: "Update Error")
            end

          nil ->
            IO.puts("No record found for ID #{id}")
        end
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
# ! run calculate_product_nutritional_content once seeding is successfully done
# DiabetesV1.Products.calculate_product_nutritional_content()
# MySeeder.seed_weight_descriptions_for_ingredients_data()
# MySeeder.seed_constants_data()
# MySeeder.seed_exercises_data("priv/repo/exercises.csv")
# MySeeder.seed_period_dates_data()
# MySeeder.seed_body_weights_data()
# MySeeder.seed_basal_changes_data()
# MySeeder.seed_dose_factor_changes_data()
# MySeeder.seed_insulin_purchases_data()
# MySeeder.seed_sensor_changes_data()
# MySeeder.seed_days_data()
# MySeeder.seed_times_data()
# MySeeder.seed_meals_data()
# MySeeder.add_event_type_for_times_data()
# MySeeder.seed_times_data_adding_split_doses()
#   * Fix exercise_id being missing
MySeeder.seed_times_exercise_id()
# todo NEXT!!!!!
#      *insert test cases for exercises
# mySeeder.insert_time_test_data("priv/repo/times-test-exercise-cases.csv")
#      *run the function on test exercise data
# MySeeder.seed_times_data_separating_exercises_in_transaction("priv/repo/times-test-exercise-cases.csv")
#      *remove test cases and new records added due to test cases
# mySeeder.delete_times_test_data()
#      !update full table for exercises BACKUP FIRST
# MySeeder.seed_times_data_separating_exercises_in_transaction("priv/repo/times.csv")
#      *insert test cases for meals
# mySeeder.insert_time_test_data("times-test-meals-cases.csv")
#      *run the function on test exercise data
# MySeeder.seed_times_data_separating_meals_in_transaction("priv/repo/times-test-meal-cases.csv")
#      *remove test cases and new records added due to test cases
# mySeeder.delete_times_test_data()
#      !update full table for meals BACKUP FIRST
# MySeeder.seed_times_data_separating_meals_in_transaction("priv/repo/times.csv")
