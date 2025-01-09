defmodule DiabetesV1.ExercisesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.Exercises

  describe "exercises" do
    alias DiabetesV1.Exercises.Exercise

    import DiabetesV1.ExercisesFixtures

    @invalid_attrs %{type: nil, description: nil, intensity: nil, met: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert Exercises.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert Exercises.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{type: "some type", description: "some description", intensity: "some intensity", met: 120.5}

      assert {:ok, %Exercise{} = exercise} = Exercises.create_exercise(valid_attrs)
      assert exercise.type == "some type"
      assert exercise.description == "some description"
      assert exercise.intensity == "some intensity"
      assert exercise.met == 120.5
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exercises.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{type: "some updated type", description: "some updated description", intensity: "some updated intensity", met: 456.7}

      assert {:ok, %Exercise{} = exercise} = Exercises.update_exercise(exercise, update_attrs)
      assert exercise.type == "some updated type"
      assert exercise.description == "some updated description"
      assert exercise.intensity == "some updated intensity"
      assert exercise.met == 456.7
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = Exercises.update_exercise(exercise, @invalid_attrs)
      assert exercise == Exercises.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = Exercises.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> Exercises.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = Exercises.change_exercise(exercise)
    end
  end
end
