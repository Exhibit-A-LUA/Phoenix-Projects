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

# ! This has been successfully run, uncomment to run again
# alias DiabetesV1.ProductMainTypes

# # Seed product_main_types from a CSV file
# IO.puts("Seeding product_main_types...")

# File.stream!("priv/repo/product_main_types.csv")
# # Skip the header row
# |> Stream.drop(1)
# |> Stream.map(&String.split(&1, ","))
# |> Enum.each(fn [id, name, description] ->
#   case ProductMainTypes.create_product_main_type(%{
#          id: String.to_integer(id),
#          name: name,
#          description: description
#        }) do
#     {:ok, _product_main_type} -> IO.puts("Product Main Type #{name} created.")
#     {:error, changeset} -> IO.inspect(changeset.errors)
#   end
# end)

# ! This has been successfully run, uncomment to run again
# alias DiabetesV1.ProductSubTypes

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

alias DiabetesV1.ProductCategories

# Seed product_categories from a CSV file
IO.puts("Seeding product_categories...")

File.stream!("priv/repo/product_categories.csv")
# Skip the header row
|> Stream.drop(1)
|> Stream.map(&String.split(&1, ","))
|> Enum.each(fn [id, name, description] ->
  case ProductCategories.create_product_category(%{
         id: String.to_integer(id),
         name: name,
         description: description
       }) do
    {:ok, _product_category} -> IO.puts("Product Category #{name} created.")
    {:error, changeset} -> IO.inspect(changeset.errors)
  end
end)
