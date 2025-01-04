alias DiabetesV1.Products
alias DiabetesV1.ProductAliases
alias DiabetesV1.Ingredients

# Insert or ensure the existence of specific products
{:ok, _} = Products.create_product(%{name: "Test Product A", serving_g: 100, calories: 200})
{:ok, _} = Products.create_product(%{name: "Test Product B", serving_g: 50, calories: 100})
{:ok, _} = Products.create_product(%{name: "Test Product C", serving_g: 80, calories: 150})
{:ok, _} = Products.create_product(%{name: "Test Product D", serving_g: 60, calories: 50})

# Insert product aliases
{:ok, _} = ProductAliases.create_product_alias(%{product_id: get_id_by_name(Products.Product, "Test Product A"), alias: "Alias A"})

# Insert ingredients
{:ok, _} = Ingredients.create_ingredient(%{
  product_id: get_id_by_name(Products.Product, "Test Product B"),
  ingredient_id: get_id_by_name(Products.Product, "Test Product A"),
  grams: 20
})

{:ok, _} = Ingredients.create_ingredient(%{
  product_id: get_id_by_name(Products.Product, "Test Product B"),
  ingredient_id: get_id_by_name(Products.Product, "Test Product D"),
  grams: 10
})


{:ok, _} = Ingredients.create_ingredient(%{
  product_id: get_id_by_name(Products.Product, "Test Product C"),
  ingredient_id: get_id_by_name(Products.Product, "Alias A"),
  grams: 40
})

{:ok, _} = Ingredients.create_ingredient(%{
  product_id: get_id_by_name(Products.Product, "Test Product C"),
  ingredient_id: get_id_by_name(Products.Product, "Test Product D"),
  grams: 20
})
