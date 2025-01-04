defmodule DiabetesV1.IngredientsTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Ingredients

  describe "ingredients" do
    alias DiabetesV1.Ingredients.Ingredient

    import DiabetesV1.IngredientsFixtures

    @invalid_attrs %{options: nil, grams: nil, included: nil}

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Ingredients.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Ingredients.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      valid_attrs = %{options: "some options", grams: 120.5, included: true}

      assert {:ok, %Ingredient{} = ingredient} = Ingredients.create_ingredient(valid_attrs)
      assert ingredient.options == "some options"
      assert ingredient.grams == 120.5
      assert ingredient.included == true
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ingredients.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      update_attrs = %{options: "some updated options", grams: 456.7, included: false}

      assert {:ok, %Ingredient{} = ingredient} = Ingredients.update_ingredient(ingredient, update_attrs)
      assert ingredient.options == "some updated options"
      assert ingredient.grams == 456.7
      assert ingredient.included == false
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Ingredients.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Ingredients.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Ingredients.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Ingredients.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Ingredients.change_ingredient(ingredient)
    end
  end
end
