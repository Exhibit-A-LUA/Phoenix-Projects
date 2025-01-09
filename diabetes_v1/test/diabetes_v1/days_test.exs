defmodule DiabetesV1.DaysTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Days

  describe "days" do
    alias DiabetesV1.Days.Day

    import DiabetesV1.DaysFixtures

    @invalid_attrs %{day_date: nil, basal: nil, icr_fixed: nil, isf_fixed: nil, fiasp_left: nil, tresiba_left: nil, sensor_day: nil, notes: nil}

    test "list_days/0 returns all days" do
      day = day_fixture()
      assert Days.list_days() == [day]
    end

    test "get_day!/1 returns the day with given id" do
      day = day_fixture()
      assert Days.get_day!(day.id) == day
    end

    test "create_day/1 with valid data creates a day" do
      valid_attrs = %{day_date: ~D[2025-01-08], basal: 42, icr_fixed: 120.5, isf_fixed: 120.5, fiasp_left: 42, tresiba_left: 42, sensor_day: 42, notes: "some notes"}

      assert {:ok, %Day{} = day} = Days.create_day(valid_attrs)
      assert day.day_date == ~D[2025-01-08]
      assert day.basal == 42
      assert day.icr_fixed == 120.5
      assert day.isf_fixed == 120.5
      assert day.fiasp_left == 42
      assert day.tresiba_left == 42
      assert day.sensor_day == 42
      assert day.notes == "some notes"
    end

    test "create_day/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Days.create_day(@invalid_attrs)
    end

    test "update_day/2 with valid data updates the day" do
      day = day_fixture()
      update_attrs = %{day_date: ~D[2025-01-09], basal: 43, icr_fixed: 456.7, isf_fixed: 456.7, fiasp_left: 43, tresiba_left: 43, sensor_day: 43, notes: "some updated notes"}

      assert {:ok, %Day{} = day} = Days.update_day(day, update_attrs)
      assert day.day_date == ~D[2025-01-09]
      assert day.basal == 43
      assert day.icr_fixed == 456.7
      assert day.isf_fixed == 456.7
      assert day.fiasp_left == 43
      assert day.tresiba_left == 43
      assert day.sensor_day == 43
      assert day.notes == "some updated notes"
    end

    test "update_day/2 with invalid data returns error changeset" do
      day = day_fixture()
      assert {:error, %Ecto.Changeset{}} = Days.update_day(day, @invalid_attrs)
      assert day == Days.get_day!(day.id)
    end

    test "delete_day/1 deletes the day" do
      day = day_fixture()
      assert {:ok, %Day{}} = Days.delete_day(day)
      assert_raise Ecto.NoResultsError, fn -> Days.get_day!(day.id) end
    end

    test "change_day/1 returns a day changeset" do
      day = day_fixture()
      assert %Ecto.Changeset{} = Days.change_day(day)
    end
  end
end
