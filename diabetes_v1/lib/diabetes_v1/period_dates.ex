defmodule DiabetesV1.PeriodDates do
  @moduledoc """
  The PeriodDates context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.PeriodDates.PeriodDate

  @doc """
  Returns the list of period_dates.

  ## Examples

      iex> list_period_dates()
      [%PeriodDate{}, ...]

  """
  def list_period_dates do
    Repo.all(PeriodDate)
  end

  @doc """
  Gets a single period_date.

  Raises `Ecto.NoResultsError` if the Period date does not exist.

  ## Examples

      iex> get_period_date!(123)
      %PeriodDate{}

      iex> get_period_date!(456)
      ** (Ecto.NoResultsError)

  """
  def get_period_date!(id), do: Repo.get!(PeriodDate, id)

  @doc """
  Creates a period_date.

  ## Examples

      iex> create_period_date(%{field: value})
      {:ok, %PeriodDate{}}

      iex> create_period_date(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_period_date(attrs \\ %{}) do
    %PeriodDate{}
    |> PeriodDate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a period_date.

  ## Examples

      iex> update_period_date(period_date, %{field: new_value})
      {:ok, %PeriodDate{}}

      iex> update_period_date(period_date, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_period_date(%PeriodDate{} = period_date, attrs) do
    period_date
    |> PeriodDate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a period_date.

  ## Examples

      iex> delete_period_date(period_date)
      {:ok, %PeriodDate{}}

      iex> delete_period_date(period_date)
      {:error, %Ecto.Changeset{}}

  """
  def delete_period_date(%PeriodDate{} = period_date) do
    Repo.delete(period_date)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking period_date changes.

  ## Examples

      iex> change_period_date(period_date)
      %Ecto.Changeset{data: %PeriodDate{}}

  """
  def change_period_date(%PeriodDate{} = period_date, attrs \\ %{}) do
    PeriodDate.changeset(period_date, attrs)
  end
end
