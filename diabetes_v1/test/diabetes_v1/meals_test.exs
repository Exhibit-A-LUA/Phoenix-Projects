defmodule DiabetesV1.MealsTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Meals

  describe "meals" do
    alias DiabetesV1.Meals.Meal

    import DiabetesV1.MealsFixtures

    @invalid_attrs %{meal_num: nil, qty: nil, weight: nil}

    test "list_meals/0 returns all meals" do
      meal = meal_fixture()
      assert Meals.list_meals() == [meal]
    end

    test "get_meal!/1 returns the meal with given id" do
      meal = meal_fixture()
      assert Meals.get_meal!(meal.id) == meal
    end

    test "create_meal/1 with valid data creates a meal" do
      valid_attrs = %{meal_num: 42, qty: 120.5, weight: 120.5}

      assert {:ok, %Meal{} = meal} = Meals.create_meal(valid_attrs)
      assert meal.meal_num == 42
      assert meal.qty == 120.5
      assert meal.weight == 120.5
    end

    test "create_meal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Meals.create_meal(@invalid_attrs)
    end

    test "update_meal/2 with valid data updates the meal" do
      meal = meal_fixture()
      update_attrs = %{meal_num: 43, qty: 456.7, weight: 456.7}

      assert {:ok, %Meal{} = meal} = Meals.update_meal(meal, update_attrs)
      assert meal.meal_num == 43
      assert meal.qty == 456.7
      assert meal.weight == 456.7
    end

    test "update_meal/2 with invalid data returns error changeset" do
      meal = meal_fixture()
      assert {:error, %Ecto.Changeset{}} = Meals.update_meal(meal, @invalid_attrs)
      assert meal == Meals.get_meal!(meal.id)
    end

    test "delete_meal/1 deletes the meal" do
      meal = meal_fixture()
      assert {:ok, %Meal{}} = Meals.delete_meal(meal)
      assert_raise Ecto.NoResultsError, fn -> Meals.get_meal!(meal.id) end
    end

    test "change_meal/1 returns a meal changeset" do
      meal = meal_fixture()
      assert %Ecto.Changeset{} = Meals.change_meal(meal)
    end
  end
end
