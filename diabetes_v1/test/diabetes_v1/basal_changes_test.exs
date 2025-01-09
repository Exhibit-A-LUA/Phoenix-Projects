defmodule DiabetesV1.BasalChangesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.BasalChanges

  describe "basal_changes" do
    alias DiabetesV1.BasalChanges.BasalChange

    import DiabetesV1.BasalChangesFixtures

    @invalid_attrs %{reason: nil, change_date: nil, doses: nil}

    test "list_basal_changes/0 returns all basal_changes" do
      basal_change = basal_change_fixture()
      assert BasalChanges.list_basal_changes() == [basal_change]
    end

    test "get_basal_change!/1 returns the basal_change with given id" do
      basal_change = basal_change_fixture()
      assert BasalChanges.get_basal_change!(basal_change.id) == basal_change
    end

    test "create_basal_change/1 with valid data creates a basal_change" do
      valid_attrs = %{reason: "some reason", change_date: ~D[2025-01-08], doses: 42}

      assert {:ok, %BasalChange{} = basal_change} = BasalChanges.create_basal_change(valid_attrs)
      assert basal_change.reason == "some reason"
      assert basal_change.change_date == ~D[2025-01-08]
      assert basal_change.doses == 42
    end

    test "create_basal_change/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BasalChanges.create_basal_change(@invalid_attrs)
    end

    test "update_basal_change/2 with valid data updates the basal_change" do
      basal_change = basal_change_fixture()
      update_attrs = %{reason: "some updated reason", change_date: ~D[2025-01-09], doses: 43}

      assert {:ok, %BasalChange{} = basal_change} = BasalChanges.update_basal_change(basal_change, update_attrs)
      assert basal_change.reason == "some updated reason"
      assert basal_change.change_date == ~D[2025-01-09]
      assert basal_change.doses == 43
    end

    test "update_basal_change/2 with invalid data returns error changeset" do
      basal_change = basal_change_fixture()
      assert {:error, %Ecto.Changeset{}} = BasalChanges.update_basal_change(basal_change, @invalid_attrs)
      assert basal_change == BasalChanges.get_basal_change!(basal_change.id)
    end

    test "delete_basal_change/1 deletes the basal_change" do
      basal_change = basal_change_fixture()
      assert {:ok, %BasalChange{}} = BasalChanges.delete_basal_change(basal_change)
      assert_raise Ecto.NoResultsError, fn -> BasalChanges.get_basal_change!(basal_change.id) end
    end

    test "change_basal_change/1 returns a basal_change changeset" do
      basal_change = basal_change_fixture()
      assert %Ecto.Changeset{} = BasalChanges.change_basal_change(basal_change)
    end
  end
end
