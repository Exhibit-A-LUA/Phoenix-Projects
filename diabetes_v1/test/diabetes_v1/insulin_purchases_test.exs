defmodule DiabetesV1.InsulinPurchasesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.InsulinPurchases

  describe "insulin_purchases" do
    alias DiabetesV1.InsulinPurchases.InsulinPurchase

    import DiabetesV1.InsulinPurchasesFixtures

    @invalid_attrs %{comments: nil, change_date: nil, fiasp_total_doses: nil, fiasp_initial_doses_used: nil, tresiba_total_doses: nil, tresiba_initial_doses_used: nil}

    test "list_insulin_purchases/0 returns all insulin_purchases" do
      insulin_purchase = insulin_purchase_fixture()
      assert InsulinPurchases.list_insulin_purchases() == [insulin_purchase]
    end

    test "get_insulin_purchase!/1 returns the insulin_purchase with given id" do
      insulin_purchase = insulin_purchase_fixture()
      assert InsulinPurchases.get_insulin_purchase!(insulin_purchase.id) == insulin_purchase
    end

    test "create_insulin_purchase/1 with valid data creates a insulin_purchase" do
      valid_attrs = %{comments: "some comments", change_date: ~D[2025-01-08], fiasp_total_doses: 42, fiasp_initial_doses_used: 42, tresiba_total_doses: 42, tresiba_initial_doses_used: 42}

      assert {:ok, %InsulinPurchase{} = insulin_purchase} = InsulinPurchases.create_insulin_purchase(valid_attrs)
      assert insulin_purchase.comments == "some comments"
      assert insulin_purchase.change_date == ~D[2025-01-08]
      assert insulin_purchase.fiasp_total_doses == 42
      assert insulin_purchase.fiasp_initial_doses_used == 42
      assert insulin_purchase.tresiba_total_doses == 42
      assert insulin_purchase.tresiba_initial_doses_used == 42
    end

    test "create_insulin_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = InsulinPurchases.create_insulin_purchase(@invalid_attrs)
    end

    test "update_insulin_purchase/2 with valid data updates the insulin_purchase" do
      insulin_purchase = insulin_purchase_fixture()
      update_attrs = %{comments: "some updated comments", change_date: ~D[2025-01-09], fiasp_total_doses: 43, fiasp_initial_doses_used: 43, tresiba_total_doses: 43, tresiba_initial_doses_used: 43}

      assert {:ok, %InsulinPurchase{} = insulin_purchase} = InsulinPurchases.update_insulin_purchase(insulin_purchase, update_attrs)
      assert insulin_purchase.comments == "some updated comments"
      assert insulin_purchase.change_date == ~D[2025-01-09]
      assert insulin_purchase.fiasp_total_doses == 43
      assert insulin_purchase.fiasp_initial_doses_used == 43
      assert insulin_purchase.tresiba_total_doses == 43
      assert insulin_purchase.tresiba_initial_doses_used == 43
    end

    test "update_insulin_purchase/2 with invalid data returns error changeset" do
      insulin_purchase = insulin_purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = InsulinPurchases.update_insulin_purchase(insulin_purchase, @invalid_attrs)
      assert insulin_purchase == InsulinPurchases.get_insulin_purchase!(insulin_purchase.id)
    end

    test "delete_insulin_purchase/1 deletes the insulin_purchase" do
      insulin_purchase = insulin_purchase_fixture()
      assert {:ok, %InsulinPurchase{}} = InsulinPurchases.delete_insulin_purchase(insulin_purchase)
      assert_raise Ecto.NoResultsError, fn -> InsulinPurchases.get_insulin_purchase!(insulin_purchase.id) end
    end

    test "change_insulin_purchase/1 returns a insulin_purchase changeset" do
      insulin_purchase = insulin_purchase_fixture()
      assert %Ecto.Changeset{} = InsulinPurchases.change_insulin_purchase(insulin_purchase)
    end
  end
end
