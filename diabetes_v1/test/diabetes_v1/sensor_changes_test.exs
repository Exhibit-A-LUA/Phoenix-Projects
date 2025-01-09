defmodule DiabetesV1.SensorChangesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.SensorChanges

  describe "sensor_changes" do
    alias DiabetesV1.SensorChanges.SensorChange

    import DiabetesV1.SensorChangesFixtures

    @invalid_attrs %{comments: nil, start_date: nil, num_days: nil}

    test "list_sensor_changes/0 returns all sensor_changes" do
      sensor_change = sensor_change_fixture()
      assert SensorChanges.list_sensor_changes() == [sensor_change]
    end

    test "get_sensor_change!/1 returns the sensor_change with given id" do
      sensor_change = sensor_change_fixture()
      assert SensorChanges.get_sensor_change!(sensor_change.id) == sensor_change
    end

    test "create_sensor_change/1 with valid data creates a sensor_change" do
      valid_attrs = %{comments: "some comments", start_date: ~D[2025-01-08], num_days: 42}

      assert {:ok, %SensorChange{} = sensor_change} = SensorChanges.create_sensor_change(valid_attrs)
      assert sensor_change.comments == "some comments"
      assert sensor_change.start_date == ~D[2025-01-08]
      assert sensor_change.num_days == 42
    end

    test "create_sensor_change/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SensorChanges.create_sensor_change(@invalid_attrs)
    end

    test "update_sensor_change/2 with valid data updates the sensor_change" do
      sensor_change = sensor_change_fixture()
      update_attrs = %{comments: "some updated comments", start_date: ~D[2025-01-09], num_days: 43}

      assert {:ok, %SensorChange{} = sensor_change} = SensorChanges.update_sensor_change(sensor_change, update_attrs)
      assert sensor_change.comments == "some updated comments"
      assert sensor_change.start_date == ~D[2025-01-09]
      assert sensor_change.num_days == 43
    end

    test "update_sensor_change/2 with invalid data returns error changeset" do
      sensor_change = sensor_change_fixture()
      assert {:error, %Ecto.Changeset{}} = SensorChanges.update_sensor_change(sensor_change, @invalid_attrs)
      assert sensor_change == SensorChanges.get_sensor_change!(sensor_change.id)
    end

    test "delete_sensor_change/1 deletes the sensor_change" do
      sensor_change = sensor_change_fixture()
      assert {:ok, %SensorChange{}} = SensorChanges.delete_sensor_change(sensor_change)
      assert_raise Ecto.NoResultsError, fn -> SensorChanges.get_sensor_change!(sensor_change.id) end
    end

    test "change_sensor_change/1 returns a sensor_change changeset" do
      sensor_change = sensor_change_fixture()
      assert %Ecto.Changeset{} = SensorChanges.change_sensor_change(sensor_change)
    end
  end
end
