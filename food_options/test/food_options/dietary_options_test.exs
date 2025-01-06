defmodule FoodOptions.DietaryOptionsTest do
  use FoodOptions.DataCase

  alias FoodOptions.DietaryOptions

  describe "dietary_options" do
    alias FoodOptions.DietaryOptions.DietaryOption

    import FoodOptions.DietaryOptionsFixtures

    @invalid_attrs %{}

    test "list_dietary_options/0 returns all dietary_options" do
      dietary_option = dietary_option_fixture()
      assert DietaryOptions.list_dietary_options() == [dietary_option]
    end

    test "get_dietary_option!/1 returns the dietary_option with given id" do
      dietary_option = dietary_option_fixture()
      assert DietaryOptions.get_dietary_option!(dietary_option.id) == dietary_option
    end

    test "create_dietary_option/1 with valid data creates a dietary_option" do
      valid_attrs = %{}

      assert {:ok, %DietaryOption{} = dietary_option} = DietaryOptions.create_dietary_option(valid_attrs)
    end

    test "create_dietary_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DietaryOptions.create_dietary_option(@invalid_attrs)
    end

    test "update_dietary_option/2 with valid data updates the dietary_option" do
      dietary_option = dietary_option_fixture()
      update_attrs = %{}

      assert {:ok, %DietaryOption{} = dietary_option} = DietaryOptions.update_dietary_option(dietary_option, update_attrs)
    end

    test "update_dietary_option/2 with invalid data returns error changeset" do
      dietary_option = dietary_option_fixture()
      assert {:error, %Ecto.Changeset{}} = DietaryOptions.update_dietary_option(dietary_option, @invalid_attrs)
      assert dietary_option == DietaryOptions.get_dietary_option!(dietary_option.id)
    end

    test "delete_dietary_option/1 deletes the dietary_option" do
      dietary_option = dietary_option_fixture()
      assert {:ok, %DietaryOption{}} = DietaryOptions.delete_dietary_option(dietary_option)
      assert_raise Ecto.NoResultsError, fn -> DietaryOptions.get_dietary_option!(dietary_option.id) end
    end

    test "change_dietary_option/1 returns a dietary_option changeset" do
      dietary_option = dietary_option_fixture()
      assert %Ecto.Changeset{} = DietaryOptions.change_dietary_option(dietary_option)
    end
  end
end
