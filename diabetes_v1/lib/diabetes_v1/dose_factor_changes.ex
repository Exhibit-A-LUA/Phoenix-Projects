defmodule DiabetesV1.DoseFactorChanges do
  @moduledoc """
  The DoseFactorChanges context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.DoseFactorChanges.DoseFactorChange

  @doc """
  Returns the list of dose_factor_changes.

  ## Examples

      iex> list_dose_factor_changes()
      [%DoseFactorChange{}, ...]

  """
  def list_dose_factor_changes do
    Repo.all(DoseFactorChange)
  end

  @doc """
  Gets a single dose_factor_change.

  Raises `Ecto.NoResultsError` if the Dose factor change does not exist.

  ## Examples

      iex> get_dose_factor_change!(123)
      %DoseFactorChange{}

      iex> get_dose_factor_change!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dose_factor_change!(id), do: Repo.get!(DoseFactorChange, id)

  @doc """
  Creates a dose_factor_change.

  ## Examples

      iex> create_dose_factor_change(%{field: value})
      {:ok, %DoseFactorChange{}}

      iex> create_dose_factor_change(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dose_factor_change(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:dose_factor_changes)
    |> DoseFactorChange.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dose_factor_change.

  ## Examples

      iex> update_dose_factor_change(dose_factor_change, %{field: new_value})
      {:ok, %DoseFactorChange{}}

      iex> update_dose_factor_change(dose_factor_change, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dose_factor_change(%DoseFactorChange{} = dose_factor_change, attrs) do
    dose_factor_change
    |> DoseFactorChange.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dose_factor_change.

  ## Examples

      iex> delete_dose_factor_change(dose_factor_change)
      {:ok, %DoseFactorChange{}}

      iex> delete_dose_factor_change(dose_factor_change)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dose_factor_change(%DoseFactorChange{} = dose_factor_change) do
    Repo.delete(dose_factor_change)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dose_factor_change changes.

  ## Examples

      iex> change_dose_factor_change(dose_factor_change)
      %Ecto.Changeset{data: %DoseFactorChange{}}

  """
  def change_dose_factor_change(%DoseFactorChange{} = dose_factor_change, attrs \\ %{}) do
    DoseFactorChange.changeset(dose_factor_change, attrs)
  end
end
