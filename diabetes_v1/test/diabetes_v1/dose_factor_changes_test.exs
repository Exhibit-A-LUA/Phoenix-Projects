defmodule DiabetesV1.DoseFactorChangesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.DoseFactorChanges

  describe "dose_factor_changes" do
    alias DiabetesV1.DoseFactorChanges.DoseFactorChange

    import DiabetesV1.DoseFactorChangesFixtures

    @invalid_attrs %{change_date: nil, isf_value: nil, icr_value: nil, notes: nil}

    test "list_dose_factor_changes/0 returns all dose_factor_changes" do
      dose_factor_change = dose_factor_change_fixture()
      assert DoseFactorChanges.list_dose_factor_changes() == [dose_factor_change]
    end

    test "get_dose_factor_change!/1 returns the dose_factor_change with given id" do
      dose_factor_change = dose_factor_change_fixture()
      assert DoseFactorChanges.get_dose_factor_change!(dose_factor_change.id) == dose_factor_change
    end

    test "create_dose_factor_change/1 with valid data creates a dose_factor_change" do
      valid_attrs = %{change_date: ~D[2025-01-08], isf_value: 120.5, icr_value: 120.5, notes: "some notes"}

      assert {:ok, %DoseFactorChange{} = dose_factor_change} = DoseFactorChanges.create_dose_factor_change(valid_attrs)
      assert dose_factor_change.change_date == ~D[2025-01-08]
      assert dose_factor_change.isf_value == 120.5
      assert dose_factor_change.icr_value == 120.5
      assert dose_factor_change.notes == "some notes"
    end

    test "create_dose_factor_change/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DoseFactorChanges.create_dose_factor_change(@invalid_attrs)
    end

    test "update_dose_factor_change/2 with valid data updates the dose_factor_change" do
      dose_factor_change = dose_factor_change_fixture()
      update_attrs = %{change_date: ~D[2025-01-09], isf_value: 456.7, icr_value: 456.7, notes: "some updated notes"}

      assert {:ok, %DoseFactorChange{} = dose_factor_change} = DoseFactorChanges.update_dose_factor_change(dose_factor_change, update_attrs)
      assert dose_factor_change.change_date == ~D[2025-01-09]
      assert dose_factor_change.isf_value == 456.7
      assert dose_factor_change.icr_value == 456.7
      assert dose_factor_change.notes == "some updated notes"
    end

    test "update_dose_factor_change/2 with invalid data returns error changeset" do
      dose_factor_change = dose_factor_change_fixture()
      assert {:error, %Ecto.Changeset{}} = DoseFactorChanges.update_dose_factor_change(dose_factor_change, @invalid_attrs)
      assert dose_factor_change == DoseFactorChanges.get_dose_factor_change!(dose_factor_change.id)
    end

    test "delete_dose_factor_change/1 deletes the dose_factor_change" do
      dose_factor_change = dose_factor_change_fixture()
      assert {:ok, %DoseFactorChange{}} = DoseFactorChanges.delete_dose_factor_change(dose_factor_change)
      assert_raise Ecto.NoResultsError, fn -> DoseFactorChanges.get_dose_factor_change!(dose_factor_change.id) end
    end

    test "change_dose_factor_change/1 returns a dose_factor_change changeset" do
      dose_factor_change = dose_factor_change_fixture()
      assert %Ecto.Changeset{} = DoseFactorChanges.change_dose_factor_change(dose_factor_change)
    end
  end
end
