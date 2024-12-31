defmodule DiabetesV1.ProductMainTypesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.ProductMainTypes

  describe "product_main_types" do
    alias DiabetesV1.ProductMainTypes.ProductMainType

    import DiabetesV1.ProductMainTypesFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_product_main_types/0 returns all product_main_types" do
      product_main_type = product_main_type_fixture()
      assert ProductMainTypes.list_product_main_types() == [product_main_type]
    end

    test "get_product_main_type!/1 returns the product_main_type with given id" do
      product_main_type = product_main_type_fixture()
      assert ProductMainTypes.get_product_main_type!(product_main_type.id) == product_main_type
    end

    test "create_product_main_type/1 with valid data creates a product_main_type" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %ProductMainType{} = product_main_type} = ProductMainTypes.create_product_main_type(valid_attrs)
      assert product_main_type.name == "some name"
      assert product_main_type.description == "some description"
    end

    test "create_product_main_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductMainTypes.create_product_main_type(@invalid_attrs)
    end

    test "update_product_main_type/2 with valid data updates the product_main_type" do
      product_main_type = product_main_type_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %ProductMainType{} = product_main_type} = ProductMainTypes.update_product_main_type(product_main_type, update_attrs)
      assert product_main_type.name == "some updated name"
      assert product_main_type.description == "some updated description"
    end

    test "update_product_main_type/2 with invalid data returns error changeset" do
      product_main_type = product_main_type_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductMainTypes.update_product_main_type(product_main_type, @invalid_attrs)
      assert product_main_type == ProductMainTypes.get_product_main_type!(product_main_type.id)
    end

    test "delete_product_main_type/1 deletes the product_main_type" do
      product_main_type = product_main_type_fixture()
      assert {:ok, %ProductMainType{}} = ProductMainTypes.delete_product_main_type(product_main_type)
      assert_raise Ecto.NoResultsError, fn -> ProductMainTypes.get_product_main_type!(product_main_type.id) end
    end

    test "change_product_main_type/1 returns a product_main_type changeset" do
      product_main_type = product_main_type_fixture()
      assert %Ecto.Changeset{} = ProductMainTypes.change_product_main_type(product_main_type)
    end
  end
end
