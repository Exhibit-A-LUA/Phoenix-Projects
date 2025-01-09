defmodule DiabetesV1.PeriodDatesTest do
  use DiabetesV1.DataCase

  alias DiabetesV1.PeriodDates

  describe "period_dates" do
    alias DiabetesV1.PeriodDates.PeriodDate

    import DiabetesV1.PeriodDatesFixtures

    @invalid_attrs %{start_date: nil}

    test "list_period_dates/0 returns all period_dates" do
      period_date = period_date_fixture()
      assert PeriodDates.list_period_dates() == [period_date]
    end

    test "get_period_date!/1 returns the period_date with given id" do
      period_date = period_date_fixture()
      assert PeriodDates.get_period_date!(period_date.id) == period_date
    end

    test "create_period_date/1 with valid data creates a period_date" do
      valid_attrs = %{start_date: ~D[2025-01-08]}

      assert {:ok, %PeriodDate{} = period_date} = PeriodDates.create_period_date(valid_attrs)
      assert period_date.start_date == ~D[2025-01-08]
    end

    test "create_period_date/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PeriodDates.create_period_date(@invalid_attrs)
    end

    test "update_period_date/2 with valid data updates the period_date" do
      period_date = period_date_fixture()
      update_attrs = %{start_date: ~D[2025-01-09]}

      assert {:ok, %PeriodDate{} = period_date} = PeriodDates.update_period_date(period_date, update_attrs)
      assert period_date.start_date == ~D[2025-01-09]
    end

    test "update_period_date/2 with invalid data returns error changeset" do
      period_date = period_date_fixture()
      assert {:error, %Ecto.Changeset{}} = PeriodDates.update_period_date(period_date, @invalid_attrs)
      assert period_date == PeriodDates.get_period_date!(period_date.id)
    end

    test "delete_period_date/1 deletes the period_date" do
      period_date = period_date_fixture()
      assert {:ok, %PeriodDate{}} = PeriodDates.delete_period_date(period_date)
      assert_raise Ecto.NoResultsError, fn -> PeriodDates.get_period_date!(period_date.id) end
    end

    test "change_period_date/1 returns a period_date changeset" do
      period_date = period_date_fixture()
      assert %Ecto.Changeset{} = PeriodDates.change_period_date(period_date)
    end
  end
end
