defmodule DiabetesV1.ProductsTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Products

  describe "products" do
    alias DiabetesV1.Products.Product

    import DiabetesV1.ProductsFixtures

    @invalid_attrs %{serving_descr: nil, fat_g: nil, v_c_ascorbic_acid_mg: nil, selenium_mcg: nil, v_b9_folate_mcg: nil, magnesium_mg: nil, sugar_alcohol_g: nil, v_a_retinol_mcg: nil, fibre_g: nil, protein_g: nil, glycemix_index: nil, calcium_mg: nil, trans_g: nil, potassium_mg: nil, v_b12_mg: nil, choline_mg: nil, poly_g: nil, v_b6_mg: nil, sodium_mg: nil, v_d_mcg: nil, cholesterol_mg: nil, v_b1_thiamin_mg: nil, v_b3_niacin_mg: nil, phosphorus_mg: nil, sat_g: nil, calories_kcal: nil, name: nil, serving_g: nil, copper_mg: nil, description: nil, zinc_mg: nil, carbs_g: nil, v_b5_mg: nil, v_k_mcg: nil, starch_g: nil, iron_mg: nil, mono_g: nil, v_e_mg: nil, v_b2_riboflavin_mg: nil, sugars_g: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{serving_descr: "some serving_descr", fat_g: 120.5, v_c_ascorbic_acid_mg: 120.5, selenium_mcg: 120.5, v_b9_folate_mcg: 120.5, magnesium_mg: 120.5, sugar_alcohol_g: 120.5, v_a_retinol_mcg: 120.5, fibre_g: 120.5, protein_g: 120.5, glycemix_index: 120.5, calcium_mg: 120.5, trans_g: 120.5, potassium_mg: 120.5, v_b12_mg: 120.5, choline_mg: 120.5, poly_g: 120.5, v_b6_mg: 120.5, sodium_mg: 120.5, v_d_mcg: 120.5, cholesterol_mg: 120.5, v_b1_thiamin_mg: 120.5, v_b3_niacin_mg: 120.5, phosphorus_mg: 120.5, sat_g: 120.5, calories_kcal: 120.5, name: "some name", serving_g: 120.5, copper_mg: 120.5, description: "some description", zinc_mg: 120.5, carbs_g: 120.5, v_b5_mg: 120.5, v_k_mcg: 120.5, starch_g: 120.5, iron_mg: 120.5, mono_g: 120.5, v_e_mg: 120.5, v_b2_riboflavin_mg: 120.5, sugars_g: 120.5}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.sugars_g == 120.5
      assert product.v_b2_riboflavin_mg == 120.5
      assert product.v_e_mg == 120.5
      assert product.mono_g == 120.5
      assert product.iron_mg == 120.5
      assert product.starch_g == 120.5
      assert product.v_k_mcg == 120.5
      assert product.v_b5_mg == 120.5
      assert product.carbs_g == 120.5
      assert product.zinc_mg == 120.5
      assert product.description == "some description"
      assert product.copper_mg == 120.5
      assert product.serving_g == 120.5
      assert product.name == "some name"
      assert product.calories_kcal == 120.5
      assert product.sat_g == 120.5
      assert product.phosphorus_mg == 120.5
      assert product.v_b3_niacin_mg == 120.5
      assert product.v_b1_thiamin_mg == 120.5
      assert product.cholesterol_mg == 120.5
      assert product.v_d_mcg == 120.5
      assert product.sodium_mg == 120.5
      assert product.v_b6_mg == 120.5
      assert product.poly_g == 120.5
      assert product.choline_mg == 120.5
      assert product.v_b12_mg == 120.5
      assert product.potassium_mg == 120.5
      assert product.trans_g == 120.5
      assert product.calcium_mg == 120.5
      assert product.glycemix_index == 120.5
      assert product.protein_g == 120.5
      assert product.fibre_g == 120.5
      assert product.v_a_retinol_mcg == 120.5
      assert product.sugar_alcohol_g == 120.5
      assert product.magnesium_mg == 120.5
      assert product.v_b9_folate_mcg == 120.5
      assert product.selenium_mcg == 120.5
      assert product.v_c_ascorbic_acid_mg == 120.5
      assert product.fat_g == 120.5
      assert product.serving_descr == "some serving_descr"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{serving_descr: "some updated serving_descr", fat_g: 456.7, v_c_ascorbic_acid_mg: 456.7, selenium_mcg: 456.7, v_b9_folate_mcg: 456.7, magnesium_mg: 456.7, sugar_alcohol_g: 456.7, v_a_retinol_mcg: 456.7, fibre_g: 456.7, protein_g: 456.7, glycemix_index: 456.7, calcium_mg: 456.7, trans_g: 456.7, potassium_mg: 456.7, v_b12_mg: 456.7, choline_mg: 456.7, poly_g: 456.7, v_b6_mg: 456.7, sodium_mg: 456.7, v_d_mcg: 456.7, cholesterol_mg: 456.7, v_b1_thiamin_mg: 456.7, v_b3_niacin_mg: 456.7, phosphorus_mg: 456.7, sat_g: 456.7, calories_kcal: 456.7, name: "some updated name", serving_g: 456.7, copper_mg: 456.7, description: "some updated description", zinc_mg: 456.7, carbs_g: 456.7, v_b5_mg: 456.7, v_k_mcg: 456.7, starch_g: 456.7, iron_mg: 456.7, mono_g: 456.7, v_e_mg: 456.7, v_b2_riboflavin_mg: 456.7, sugars_g: 456.7}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.sugars_g == 456.7
      assert product.v_b2_riboflavin_mg == 456.7
      assert product.v_e_mg == 456.7
      assert product.mono_g == 456.7
      assert product.iron_mg == 456.7
      assert product.starch_g == 456.7
      assert product.v_k_mcg == 456.7
      assert product.v_b5_mg == 456.7
      assert product.carbs_g == 456.7
      assert product.zinc_mg == 456.7
      assert product.description == "some updated description"
      assert product.copper_mg == 456.7
      assert product.serving_g == 456.7
      assert product.name == "some updated name"
      assert product.calories_kcal == 456.7
      assert product.sat_g == 456.7
      assert product.phosphorus_mg == 456.7
      assert product.v_b3_niacin_mg == 456.7
      assert product.v_b1_thiamin_mg == 456.7
      assert product.cholesterol_mg == 456.7
      assert product.v_d_mcg == 456.7
      assert product.sodium_mg == 456.7
      assert product.v_b6_mg == 456.7
      assert product.poly_g == 456.7
      assert product.choline_mg == 456.7
      assert product.v_b12_mg == 456.7
      assert product.potassium_mg == 456.7
      assert product.trans_g == 456.7
      assert product.calcium_mg == 456.7
      assert product.glycemix_index == 456.7
      assert product.protein_g == 456.7
      assert product.fibre_g == 456.7
      assert product.v_a_retinol_mcg == 456.7
      assert product.sugar_alcohol_g == 456.7
      assert product.magnesium_mg == 456.7
      assert product.v_b9_folate_mcg == 456.7
      assert product.selenium_mcg == 456.7
      assert product.v_c_ascorbic_acid_mg == 456.7
      assert product.fat_g == 456.7
      assert product.serving_descr == "some updated serving_descr"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
