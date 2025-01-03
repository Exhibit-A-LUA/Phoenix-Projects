defmodule DiabetesV1.ProductAliasesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.ProductAliases

  describe "product_aliases" do
    alias DiabetesV1.ProductAliases.ProductAlias

    import DiabetesV1.ProductAliasesFixtures

    @invalid_attrs %{alias: nil, string: nil}

    test "list_product_aliases/0 returns all product_aliases" do
      product_alias = product_alias_fixture()
      assert ProductAliases.list_product_aliases() == [product_alias]
    end

    test "get_product_alias!/1 returns the product_alias with given id" do
      product_alias = product_alias_fixture()
      assert ProductAliases.get_product_alias!(product_alias.id) == product_alias
    end

    test "create_product_alias/1 with valid data creates a product_alias" do
      valid_attrs = %{alias: "some alias", string: "some string"}

      assert {:ok, %ProductAlias{} = product_alias} = ProductAliases.create_product_alias(valid_attrs)
      assert product_alias.alias == "some alias"
      assert product_alias.string == "some string"
    end

    test "create_product_alias/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductAliases.create_product_alias(@invalid_attrs)
    end

    test "update_product_alias/2 with valid data updates the product_alias" do
      product_alias = product_alias_fixture()
      update_attrs = %{alias: "some updated alias", string: "some updated string"}

      assert {:ok, %ProductAlias{} = product_alias} = ProductAliases.update_product_alias(product_alias, update_attrs)
      assert product_alias.alias == "some updated alias"
      assert product_alias.string == "some updated string"
    end

    test "update_product_alias/2 with invalid data returns error changeset" do
      product_alias = product_alias_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductAliases.update_product_alias(product_alias, @invalid_attrs)
      assert product_alias == ProductAliases.get_product_alias!(product_alias.id)
    end

    test "delete_product_alias/1 deletes the product_alias" do
      product_alias = product_alias_fixture()
      assert {:ok, %ProductAlias{}} = ProductAliases.delete_product_alias(product_alias)
      assert_raise Ecto.NoResultsError, fn -> ProductAliases.get_product_alias!(product_alias.id) end
    end

    test "change_product_alias/1 returns a product_alias changeset" do
      product_alias = product_alias_fixture()
      assert %Ecto.Changeset{} = ProductAliases.change_product_alias(product_alias)
    end
  end
end
