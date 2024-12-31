defmodule DiabetesV1.ProductSubTypes do
  @moduledoc """
  The ProductSubTypes context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.ProductSubTypes.ProductSubType

  @doc """
  Returns the list of product_sub_types.

  ## Examples

      iex> list_product_sub_types()
      [%ProductSubType{}, ...]

  """
  def list_product_sub_types do
    Repo.all(ProductSubType)
  end

  @doc """
  Gets a single product_sub_type.

  Raises `Ecto.NoResultsError` if the Product sub type does not exist.

  ## Examples

      iex> get_product_sub_type!(123)
      %ProductSubType{}

      iex> get_product_sub_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_sub_type!(id), do: Repo.get!(ProductSubType, id)

  @doc """
  Creates a product_sub_type.

  ## Examples

      iex> create_product_sub_type(%{field: value})
      {:ok, %ProductSubType{}}

      iex> create_product_sub_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_sub_type(attrs \\ %{}) do
    %ProductSubType{}
    |> ProductSubType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_sub_type.

  ## Examples

      iex> update_product_sub_type(product_sub_type, %{field: new_value})
      {:ok, %ProductSubType{}}

      iex> update_product_sub_type(product_sub_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_sub_type(%ProductSubType{} = product_sub_type, attrs) do
    product_sub_type
    |> ProductSubType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_sub_type.

  ## Examples

      iex> delete_product_sub_type(product_sub_type)
      {:ok, %ProductSubType{}}

      iex> delete_product_sub_type(product_sub_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_sub_type(%ProductSubType{} = product_sub_type) do
    Repo.delete(product_sub_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_sub_type changes.

  ## Examples

      iex> change_product_sub_type(product_sub_type)
      %Ecto.Changeset{data: %ProductSubType{}}

  """
  def change_product_sub_type(%ProductSubType{} = product_sub_type, attrs \\ %{}) do
    ProductSubType.changeset(product_sub_type, attrs)
  end
end
