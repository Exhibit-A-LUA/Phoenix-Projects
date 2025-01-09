defmodule DiabetesV1.TimesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Times

  describe "times" do
    alias DiabetesV1.Times.Time

    import DiabetesV1.TimesFixtures

    @invalid_attrs %{reading_time: nil, blood_sugar: nil, meal_num: nil, dose_time: nil, doses: nil, meal_time: nil, exercise_start: nil, exercise_end: nil}

    test "list_times/0 returns all times" do
      time = time_fixture()
      assert Times.list_times() == [time]
    end

    test "get_time!/1 returns the time with given id" do
      time = time_fixture()
      assert Times.get_time!(time.id) == time
    end

    test "create_time/1 with valid data creates a time" do
      valid_attrs = %{reading_time: ~T[14:00:00], blood_sugar: 42, meal_num: 42, dose_time: ~T[14:00:00], doses: 42, meal_time: ~T[14:00:00], exercise_start: ~T[14:00:00], exercise_end: ~T[14:00:00]}

      assert {:ok, %Time{} = time} = Times.create_time(valid_attrs)
      assert time.reading_time == ~T[14:00:00]
      assert time.blood_sugar == 42
      assert time.meal_num == 42
      assert time.dose_time == ~T[14:00:00]
      assert time.doses == 42
      assert time.meal_time == ~T[14:00:00]
      assert time.exercise_start == ~T[14:00:00]
      assert time.exercise_end == ~T[14:00:00]
    end

    test "create_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Times.create_time(@invalid_attrs)
    end

    test "update_time/2 with valid data updates the time" do
      time = time_fixture()
      update_attrs = %{reading_time: ~T[15:01:01], blood_sugar: 43, meal_num: 43, dose_time: ~T[15:01:01], doses: 43, meal_time: ~T[15:01:01], exercise_start: ~T[15:01:01], exercise_end: ~T[15:01:01]}

      assert {:ok, %Time{} = time} = Times.update_time(time, update_attrs)
      assert time.reading_time == ~T[15:01:01]
      assert time.blood_sugar == 43
      assert time.meal_num == 43
      assert time.dose_time == ~T[15:01:01]
      assert time.doses == 43
      assert time.meal_time == ~T[15:01:01]
      assert time.exercise_start == ~T[15:01:01]
      assert time.exercise_end == ~T[15:01:01]
    end

    test "update_time/2 with invalid data returns error changeset" do
      time = time_fixture()
      assert {:error, %Ecto.Changeset{}} = Times.update_time(time, @invalid_attrs)
      assert time == Times.get_time!(time.id)
    end

    test "delete_time/1 deletes the time" do
      time = time_fixture()
      assert {:ok, %Time{}} = Times.delete_time(time)
      assert_raise Ecto.NoResultsError, fn -> Times.get_time!(time.id) end
    end

    test "change_time/1 returns a time changeset" do
      time = time_fixture()
      assert %Ecto.Changeset{} = Times.change_time(time)
    end
  end
end
