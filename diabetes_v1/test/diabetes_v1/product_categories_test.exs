defmodule DiabetesV1.ProductCategoriesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.ProductCategories

  describe "product_categories" do
    alias DiabetesV1.ProductCategories.ProductCategory

    import DiabetesV1.ProductCategoriesFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_product_categories/0 returns all product_categories" do
      product_category = product_category_fixture()
      assert ProductCategories.list_product_categories() == [product_category]
    end

    test "get_product_category!/1 returns the product_category with given id" do
      product_category = product_category_fixture()
      assert ProductCategories.get_product_category!(product_category.id) == product_category
    end

    test "create_product_category/1 with valid data creates a product_category" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %ProductCategory{} = product_category} = ProductCategories.create_product_category(valid_attrs)
      assert product_category.name == "some name"
      assert product_category.description == "some description"
    end

    test "create_product_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductCategories.create_product_category(@invalid_attrs)
    end

    test "update_product_category/2 with valid data updates the product_category" do
      product_category = product_category_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %ProductCategory{} = product_category} = ProductCategories.update_product_category(product_category, update_attrs)
      assert product_category.name == "some updated name"
      assert product_category.description == "some updated description"
    end

    test "update_product_category/2 with invalid data returns error changeset" do
      product_category = product_category_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductCategories.update_product_category(product_category, @invalid_attrs)
      assert product_category == ProductCategories.get_product_category!(product_category.id)
    end

    test "delete_product_category/1 deletes the product_category" do
      product_category = product_category_fixture()
      assert {:ok, %ProductCategory{}} = ProductCategories.delete_product_category(product_category)
      assert_raise Ecto.NoResultsError, fn -> ProductCategories.get_product_category!(product_category.id) end
    end

    test "change_product_category/1 returns a product_category changeset" do
      product_category = product_category_fixture()
      assert %Ecto.Changeset{} = ProductCategories.change_product_category(product_category)
    end
  end
end
