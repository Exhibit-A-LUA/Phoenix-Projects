defmodule DiabetesV1.BodyWeightsTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.BodyWeights

  describe "body_weights" do
    alias DiabetesV1.BodyWeights.BodyWeight

    import DiabetesV1.BodyWeightsFixtures

    @invalid_attrs %{reading_date: nil, weight_kg: nil}

    test "list_body_weights/0 returns all body_weights" do
      body_weight = body_weight_fixture()
      assert BodyWeights.list_body_weights() == [body_weight]
    end

    test "get_body_weight!/1 returns the body_weight with given id" do
      body_weight = body_weight_fixture()
      assert BodyWeights.get_body_weight!(body_weight.id) == body_weight
    end

    test "create_body_weight/1 with valid data creates a body_weight" do
      valid_attrs = %{reading_date: ~D[2025-01-08], weight_kg: 120.5}

      assert {:ok, %BodyWeight{} = body_weight} = BodyWeights.create_body_weight(valid_attrs)
      assert body_weight.reading_date == ~D[2025-01-08]
      assert body_weight.weight_kg == 120.5
    end

    test "create_body_weight/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BodyWeights.create_body_weight(@invalid_attrs)
    end

    test "update_body_weight/2 with valid data updates the body_weight" do
      body_weight = body_weight_fixture()
      update_attrs = %{reading_date: ~D[2025-01-09], weight_kg: 456.7}

      assert {:ok, %BodyWeight{} = body_weight} = BodyWeights.update_body_weight(body_weight, update_attrs)
      assert body_weight.reading_date == ~D[2025-01-09]
      assert body_weight.weight_kg == 456.7
    end

    test "update_body_weight/2 with invalid data returns error changeset" do
      body_weight = body_weight_fixture()
      assert {:error, %Ecto.Changeset{}} = BodyWeights.update_body_weight(body_weight, @invalid_attrs)
      assert body_weight == BodyWeights.get_body_weight!(body_weight.id)
    end

    test "delete_body_weight/1 deletes the body_weight" do
      body_weight = body_weight_fixture()
      assert {:ok, %BodyWeight{}} = BodyWeights.delete_body_weight(body_weight)
      assert_raise Ecto.NoResultsError, fn -> BodyWeights.get_body_weight!(body_weight.id) end
    end

    test "change_body_weight/1 returns a body_weight changeset" do
      body_weight = body_weight_fixture()
      assert %Ecto.Changeset{} = BodyWeights.change_body_weight(body_weight)
    end
  end
end
