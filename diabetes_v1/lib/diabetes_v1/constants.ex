defmodule DiabetesV1.Constants do
  @moduledoc """
  The Constants context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.Constants.Constant

  @doc """
  Returns the list of constants.

  ## Examples

      iex> list_constants()
      [%Constant{}, ...]

  """
  def list_constants do
    Repo.all(Constant)
  end

  @doc """
  Gets a single constant.

  Raises `Ecto.NoResultsError` if the Constant does not exist.

  ## Examples

      iex> get_constant!(123)
      %Constant{}

      iex> get_constant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_constant!(id), do: Repo.get!(Constant, id)

  @doc """
  Creates a constant.

  ## Examples

      iex> create_constant(%{field: value})
      {:ok, %Constant{}}

      iex> create_constant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_constant(attrs \\ %{}) do
    %Constant{}
    |> Constant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a constant.

  ## Examples

      iex> update_constant(constant, %{field: new_value})
      {:ok, %Constant{}}

      iex> update_constant(constant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_constant(%Constant{} = constant, attrs) do
    constant
    |> Constant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a constant.

  ## Examples

      iex> delete_constant(constant)
      {:ok, %Constant{}}

      iex> delete_constant(constant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_constant(%Constant{} = constant) do
    Repo.delete(constant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking constant changes.

  ## Examples

      iex> change_constant(constant)
      %Ecto.Changeset{data: %Constant{}}

  """
  def change_constant(%Constant{} = constant, attrs \\ %{}) do
    Constant.changeset(constant, attrs)
  end
end
