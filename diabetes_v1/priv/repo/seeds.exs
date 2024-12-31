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

alias DiabetesV1.ProductMainTypes

# Seed product_main_types from a CSV file
IO.puts("Seeding product_main_types...")

File.stream!("priv/repo/product_main_types.csv")
# Skip the header row
|> Stream.drop(1)
|> Stream.map(&String.split(&1, ","))
|> Enum.each(fn [id, name, description] ->
  case ProductMainTypes.create_product_main_type(%{
         id: String.to_integer(id),
         name: name,
         description: description
       }) do
    {:ok, _product_main_type} -> IO.puts("Product Main Type #{name} created.")
    {:error, changeset} -> IO.inspect(changeset.errors)
  end
end)
