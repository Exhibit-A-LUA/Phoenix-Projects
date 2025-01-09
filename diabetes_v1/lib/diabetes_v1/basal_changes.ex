defmodule DiabetesV1.BasalChanges do
  @moduledoc """
  The BasalChanges context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.BasalChanges.BasalChange

  @doc """
  Returns the list of basal_changes.

  ## Examples

      iex> list_basal_changes()
      [%BasalChange{}, ...]

  """
  def list_basal_changes do
    Repo.all(BasalChange)
  end

  @doc """
  Gets a single basal_change.

  Raises `Ecto.NoResultsError` if the Basal change does not exist.

  ## Examples

      iex> get_basal_change!(123)
      %BasalChange{}

      iex> get_basal_change!(456)
      ** (Ecto.NoResultsError)

  """
  def get_basal_change!(id), do: Repo.get!(BasalChange, id)

  @doc """
  Creates a basal_change.

  ## Examples

      iex> create_basal_change(%{field: value})
      {:ok, %BasalChange{}}

      iex> create_basal_change(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_basal_change(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:basal_changes)
    |> BasalChange.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a basal_change.

  ## Examples

      iex> update_basal_change(basal_change, %{field: new_value})
      {:ok, %BasalChange{}}

      iex> update_basal_change(basal_change, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_basal_change(%BasalChange{} = basal_change, attrs) do
    basal_change
    |> BasalChange.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a basal_change.

  ## Examples

      iex> delete_basal_change(basal_change)
      {:ok, %BasalChange{}}

      iex> delete_basal_change(basal_change)
      {:error, %Ecto.Changeset{}}

  """
  def delete_basal_change(%BasalChange{} = basal_change) do
    Repo.delete(basal_change)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking basal_change changes.

  ## Examples

      iex> change_basal_change(basal_change)
      %Ecto.Changeset{data: %BasalChange{}}

  """
  def change_basal_change(%BasalChange{} = basal_change, attrs \\ %{}) do
    BasalChange.changeset(basal_change, attrs)
  end
end
