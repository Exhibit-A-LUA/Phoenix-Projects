defmodule DiabetesV1.AddressesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Addresses

  describe "addresses" do
    alias DiabetesV1.Addresses.Address

    import DiabetesV1.AddressesFixtures

    @invalid_attrs %{address_line1: nil, address_line2: nil, city: nil, postal_code: nil, country: nil, telephone: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{address_line1: "some address_line1", address_line2: "some address_line2", city: "some city", postal_code: "some postal_code", country: "some country", telephone: "some telephone"}

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.address_line1 == "some address_line1"
      assert address.address_line2 == "some address_line2"
      assert address.city == "some city"
      assert address.postal_code == "some postal_code"
      assert address.country == "some country"
      assert address.telephone == "some telephone"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{address_line1: "some updated address_line1", address_line2: "some updated address_line2", city: "some updated city", postal_code: "some updated postal_code", country: "some updated country", telephone: "some updated telephone"}

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.address_line1 == "some updated address_line1"
      assert address.address_line2 == "some updated address_line2"
      assert address.city == "some updated city"
      assert address.postal_code == "some updated postal_code"
      assert address.country == "some updated country"
      assert address.telephone == "some updated telephone"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
