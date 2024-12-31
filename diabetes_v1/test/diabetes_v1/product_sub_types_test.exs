defmodule DiabetesV1.ProductSubTypesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.ProductSubTypes

  describe "product_sub_types" do
    alias DiabetesV1.ProductSubTypes.ProductSubType

    import DiabetesV1.ProductSubTypesFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_product_sub_types/0 returns all product_sub_types" do
      product_sub_type = product_sub_type_fixture()
      assert ProductSubTypes.list_product_sub_types() == [product_sub_type]
    end

    test "get_product_sub_type!/1 returns the product_sub_type with given id" do
      product_sub_type = product_sub_type_fixture()
      assert ProductSubTypes.get_product_sub_type!(product_sub_type.id) == product_sub_type
    end

    test "create_product_sub_type/1 with valid data creates a product_sub_type" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %ProductSubType{} = product_sub_type} = ProductSubTypes.create_product_sub_type(valid_attrs)
      assert product_sub_type.name == "some name"
      assert product_sub_type.description == "some description"
    end

    test "create_product_sub_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductSubTypes.create_product_sub_type(@invalid_attrs)
    end

    test "update_product_sub_type/2 with valid data updates the product_sub_type" do
      product_sub_type = product_sub_type_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %ProductSubType{} = product_sub_type} = ProductSubTypes.update_product_sub_type(product_sub_type, update_attrs)
      assert product_sub_type.name == "some updated name"
      assert product_sub_type.description == "some updated description"
    end

    test "update_product_sub_type/2 with invalid data returns error changeset" do
      product_sub_type = product_sub_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductSubTypes.update_product_sub_type(product_sub_type, @invalid_attrs)
      assert product_sub_type == ProductSubTypes.get_product_sub_type!(product_sub_type.id)
    end

    test "delete_product_sub_type/1 deletes the product_sub_type" do
      product_sub_type = product_sub_type_fixture()
      assert {:ok, %ProductSubType{}} = ProductSubTypes.delete_product_sub_type(product_sub_type)
      assert_raise Ecto.NoResultsError, fn -> ProductSubTypes.get_product_sub_type!(product_sub_type.id) end
    end

    test "change_product_sub_type/1 returns a product_sub_type changeset" do
      product_sub_type = product_sub_type_fixture()
      assert %Ecto.Changeset{} = ProductSubTypes.change_product_sub_type(product_sub_type)
    end
  end
end
