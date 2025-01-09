defmodule DiabetesV1.SensorChanges do
  @moduledoc """
  The SensorChanges context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.SensorChanges.SensorChange

  @doc """
  Returns the list of sensor_changes.

  ## Examples

      iex> list_sensor_changes()
      [%SensorChange{}, ...]

  """
  def list_sensor_changes do
    Repo.all(SensorChange)
  end

  @doc """
  Gets a single sensor_change.

  Raises `Ecto.NoResultsError` if the Sensor change does not exist.

  ## Examples

      iex> get_sensor_change!(123)
      %SensorChange{}

      iex> get_sensor_change!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sensor_change!(id), do: Repo.get!(SensorChange, id)

  @doc """
  Creates a sensor_change.

  ## Examples

      iex> create_sensor_change(%{field: value})
      {:ok, %SensorChange{}}

      iex> create_sensor_change(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sensor_change(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:sensor_changes)
    |> SensorChange.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sensor_change.

  ## Examples

      iex> update_sensor_change(sensor_change, %{field: new_value})
      {:ok, %SensorChange{}}

      iex> update_sensor_change(sensor_change, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sensor_change(%SensorChange{} = sensor_change, attrs) do
    sensor_change
    |> SensorChange.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sensor_change.

  ## Examples

      iex> delete_sensor_change(sensor_change)
      {:ok, %SensorChange{}}

      iex> delete_sensor_change(sensor_change)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sensor_change(%SensorChange{} = sensor_change) do
    Repo.delete(sensor_change)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sensor_change changes.

  ## Examples

      iex> change_sensor_change(sensor_change)
      %Ecto.Changeset{data: %SensorChange{}}

  """
  def change_sensor_change(%SensorChange{} = sensor_change, attrs \\ %{}) do
    SensorChange.changeset(sensor_change, attrs)
  end
end
