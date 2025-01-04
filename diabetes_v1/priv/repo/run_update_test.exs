# This runs update_recipe_nutrition for Test Product B which uses Test Product A as an ingredient
# and Test Product C which uses an Alias for Test Product A as an ingredient.

# It will print out the details of the three test products after updating their nutritional values

# Then it will delete the test products, aliases and ingredients

recipe_ids = [
  get_id_by_name(DiabetesV1.Products.Product, "Test Product B"),
  get_id_by_name(DiabetesV1.Products.Product, "Test Product C")
]

Enum.each(recipe_ids, &update_recipe_nutrition(&1))

IO.inspect(
  Repo.all(
    from p in DiabetesV1.Products.Product,
    where: p.name in ["Test Product B", "Test Product C"],
    select: %{name: p.name, calories: p.calories}
  )
)

# ! Expected Output

# [
#   %{name: "Test Product B", calories: 73.33},
#   %{name: "Test Product C", calories: 236.67}
# ]

Repo.delete_all(
  from p in DiabetesV1.Products.Product, where: p.name in ["Test Product A", "Test Product B", "Test Product C"]
)

Repo.delete_all(
  from a in DiabetesV1.ProductAliases.ProductAlias, where: a.alias in ["Alias A"]
)

Repo.delete_all(
  from i in DiabetesV1.Ingredients.Ingredient, where: i.product_id in recipe_ids
)
