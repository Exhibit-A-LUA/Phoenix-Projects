defmodule DiabetesV1.BodyWeights do
  @moduledoc """
  The BodyWeights context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.BodyWeights.BodyWeight

  @doc """
  Returns the list of body_weights.

  ## Examples

      iex> list_body_weights()
      [%BodyWeight{}, ...]

  """
  def list_body_weights do
    Repo.all(BodyWeight)
  end

  @doc """
  Gets a single body_weight.

  Raises `Ecto.NoResultsError` if the Body weight does not exist.

  ## Examples

      iex> get_body_weight!(123)
      %BodyWeight{}

      iex> get_body_weight!(456)
      ** (Ecto.NoResultsError)

  """
  def get_body_weight!(id), do: Repo.get!(BodyWeight, id)

  @doc """
  Creates a body_weight.

  ## Examples

      iex> create_body_weight(%{field: value})
      {:ok, %BodyWeight{}}

      iex> create_body_weight(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_body_weight(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:body_weights)
    |> BodyWeight.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a body_weight.

  ## Examples

      iex> update_body_weight(body_weight, %{field: new_value})
      {:ok, %BodyWeight{}}

      iex> update_body_weight(body_weight, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_body_weight(%BodyWeight{} = body_weight, attrs) do
    body_weight
    |> BodyWeight.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a body_weight.

  ## Examples

      iex> delete_body_weight(body_weight)
      {:ok, %BodyWeight{}}

      iex> delete_body_weight(body_weight)
      {:error, %Ecto.Changeset{}}

  """
  def delete_body_weight(%BodyWeight{} = body_weight) do
    Repo.delete(body_weight)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking body_weight changes.

  ## Examples

      iex> change_body_weight(body_weight)
      %Ecto.Changeset{data: %BodyWeight{}}

  """
  def change_body_weight(%BodyWeight{} = body_weight, attrs \\ %{}) do
    BodyWeight.changeset(body_weight, attrs)
  end
end
