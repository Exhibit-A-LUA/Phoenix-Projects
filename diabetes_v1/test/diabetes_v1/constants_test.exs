defmodule DiabetesV1.ConstantsTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Constants

  describe "constants" do
    alias DiabetesV1.Constants.Constant

    import DiabetesV1.ConstantsFixtures

    @invalid_attrs %{value: nil, description: nil, key: nil, notes: nil}

    test "list_constants/0 returns all constants" do
      constant = constant_fixture()
      assert Constants.list_constants() == [constant]
    end

    test "get_constant!/1 returns the constant with given id" do
      constant = constant_fixture()
      assert Constants.get_constant!(constant.id) == constant
    end

    test "create_constant/1 with valid data creates a constant" do
      valid_attrs = %{value: 120.5, description: "some description", key: "some key", notes: "some notes"}

      assert {:ok, %Constant{} = constant} = Constants.create_constant(valid_attrs)
      assert constant.value == 120.5
      assert constant.description == "some description"
      assert constant.key == "some key"
      assert constant.notes == "some notes"
    end

    test "create_constant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Constants.create_constant(@invalid_attrs)
    end

    test "update_constant/2 with valid data updates the constant" do
      constant = constant_fixture()
      update_attrs = %{value: 456.7, description: "some updated description", key: "some updated key", notes: "some updated notes"}

      assert {:ok, %Constant{} = constant} = Constants.update_constant(constant, update_attrs)
      assert constant.value == 456.7
      assert constant.description == "some updated description"
      assert constant.key == "some updated key"
      assert constant.notes == "some updated notes"
    end

    test "update_constant/2 with invalid data returns error changeset" do
      constant = constant_fixture()
      assert {:error, %Ecto.Changeset{}} = Constants.update_constant(constant, @invalid_attrs)
      assert constant == Constants.get_constant!(constant.id)
    end

    test "delete_constant/1 deletes the constant" do
      constant = constant_fixture()
      assert {:ok, %Constant{}} = Constants.delete_constant(constant)
      assert_raise Ecto.NoResultsError, fn -> Constants.get_constant!(constant.id) end
    end

    test "change_constant/1 returns a constant changeset" do
      constant = constant_fixture()
      assert %Ecto.Changeset{} = Constants.change_constant(constant)
    end
  end
end
