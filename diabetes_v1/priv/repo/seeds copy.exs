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

alias DiabetesV1.Repo
alias DiabetesV1.Products.Product
alias DiabetesV1.ProductMainTypes.ProductMainType
alias DiabetesV1.ProductSubTypes.ProductSubType
alias DiabetesV1.ProductCategories.ProductCategory

# ! This has been successfully run, uncomment to run again
# * ProductMainTypes

alias DiabetesV1.ProductMainTypes

# Repo.delete_all(ProductMainType)

# Seed product_main_types from a CSV file
IO.puts("Seeding product_main_types...")

# File.stream!("priv/repo/product_main_types.csv")
# # Skip the header row
# |> Stream.drop(1)
# |> Stream.map(&String.split(&1, ","))
# |> Enum.each(fn [id, name, description] ->
#   case ProductMainTypes.create_product_main_type(%{
#          id: String.to_integer(id),
#          name: String.trim(name, "\""),
#          description: String.trim(description, "\"")
#        }) do
#     {:ok, _product_main_type} -> IO.puts("Product Main Type #{name} created.")
#     {:error, changeset} -> IO.inspect(changeset.errors)
#   end
# end)

# ! This has been successfully run, uncomment to run again
# * ProductSubTypes
alias DiabetesV1.ProductSubTypes

# Repo.delete_all(ProductSubType)

# # Seed product_sub_types from a CSV file
# IO.puts("Seeding product_sub_types...")

# File.stream!("priv/repo/product_sub_types.csv")
# # Skip the header row
# |> Stream.drop(1)
# |> Stream.map(&String.split(&1, ","))
# |> Enum.each(fn [id, name, description] ->
#   case ProductSubTypes.create_product_sub_type(%{
#          id: String.to_integer(id),
#          name: name,
#          description: description
#        }) do
#     {:ok, _product_sub_type} -> IO.puts("Product Sub Type #{name} created.")
#     {:error, changeset} -> IO.inspect(changeset.errors)
#   end
# end)

# ! This has been successfully run, uncomment to run again
# * ProductCategories
alias DiabetesV1.ProductCategories

# Repo.delete_all(ProductCategory)

# Seed product_categories from a CSV file
# IO.puts("Seeding product_categories...")

# File.stream!("priv/repo/product_categories.csv")
# # Skip the header row
# |> Stream.drop(1)
# |> Stream.map(&String.split(&1, ","))
# |> Enum.each(fn [id, name, description] ->
#   case ProductCategories.create_product_category(%{
#          id: String.to_integer(id),
#          name: name,
#          description: description
#        }) do
#     {:ok, _product_category} -> IO.puts("Product Category #{name} created.")
#     {:error, changeset} -> IO.inspect(changeset.errors)
#   end
# end)

# * Products
defmodule MySeeder do
  # Helper function to fetch ID by name
  defp get_id_by_name(module, name) do
    Repo.get_by(module, name: name)
    |> case do
      nil -> raise "No record found for #{name} in #{module}"
      record -> record.id
    end
  end

  defp get_float(name) do
    name
    |> Float.parse()
    |> elem(0)
  end

  def seed_data do
    # Load and parse the CSV
    {:ok, csv} = File.read("priv/repo/products.csv")

    rows =
      csv
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ","))

    # Skip the header row and iterate over the rows
    Enum.each(tl(rows), fn row ->
      [
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
      ] = row

      # Resolve IDs for associations
      main_type_name = String.trim(main_type_name, "\"")
      IO.inspect(main_type_name)
      main_type_id = get_id_by_name(ProductMainType, main_type_name)
      sub_type_id = get_id_by_name(ProductSubType, sub_type_name)
      category_id = get_id_by_name(ProductCategory, category_name)

      # Insert the product
      %Product{
        id: String.to_integer(id),
        main_type_id: main_type_id,
        sub_type_id: sub_type_id,
        category_id: category_id,
        description: description,
        name: name,
        serving_g: get_float(serving_g),
        serving_descr: serving_descr,
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
      }
      |> Repo.insert!()
    end)
  end
end

# MySeeder.seed_data()
