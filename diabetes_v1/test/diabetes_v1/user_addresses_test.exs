defmodule DiabetesV1.UserAddressesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.UserAddresses

  describe "user_addresses" do
    alias DiabetesV1.UserAddresses.UserAddress

    import DiabetesV1.UserAddressesFixtures

    @invalid_attrs %{}

    test "list_user_addresses/0 returns all user_addresses" do
      user_address = user_address_fixture()
      assert UserAddresses.list_user_addresses() == [user_address]
    end

    test "get_user_address!/1 returns the user_address with given id" do
      user_address = user_address_fixture()
      assert UserAddresses.get_user_address!(user_address.id) == user_address
    end

    test "create_user_address/1 with valid data creates a user_address" do
      valid_attrs = %{}

      assert {:ok, %UserAddress{} = user_address} = UserAddresses.create_user_address(valid_attrs)
    end

    test "create_user_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserAddresses.create_user_address(@invalid_attrs)
    end

    test "update_user_address/2 with valid data updates the user_address" do
      user_address = user_address_fixture()
      update_attrs = %{}

      assert {:ok, %UserAddress{} = user_address} = UserAddresses.update_user_address(user_address, update_attrs)
    end

    test "update_user_address/2 with invalid data returns error changeset" do
      user_address = user_address_fixture()
      assert {:error, %Ecto.Changeset{}} = UserAddresses.update_user_address(user_address, @invalid_attrs)
      assert user_address == UserAddresses.get_user_address!(user_address.id)
    end

    test "delete_user_address/1 deletes the user_address" do
      user_address = user_address_fixture()
      assert {:ok, %UserAddress{}} = UserAddresses.delete_user_address(user_address)
      assert_raise Ecto.NoResultsError, fn -> UserAddresses.get_user_address!(user_address.id) end
    end

    test "change_user_address/1 returns a user_address changeset" do
      user_address = user_address_fixture()
      assert %Ecto.Changeset{} = UserAddresses.change_user_address(user_address)
    end
  end
end
