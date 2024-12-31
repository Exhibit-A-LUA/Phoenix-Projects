defmodule DiabetesV1.ProductMainTypes do
  @moduledoc """
  The ProductMainTypes context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.ProductMainTypes.ProductMainType

  @doc """
  Returns the list of product_main_types.

  ## Examples

      iex> list_product_main_types()
      [%ProductMainType{}, ...]

  """
  def list_product_main_types do
    Repo.all(ProductMainType)
  end

  @doc """
  Gets a single product_main_type.

  Raises `Ecto.NoResultsError` if the Product main type does not exist.

  ## Examples

      iex> get_product_main_type!(123)
      %ProductMainType{}

      iex> get_product_main_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_main_type!(id), do: Repo.get!(ProductMainType, id)

  @doc """
  Creates a product_main_type.

  ## Examples

      iex> create_product_main_type(%{field: value})
      {:ok, %ProductMainType{}}

      iex> create_product_main_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_main_type(attrs \\ %{}) do
    %ProductMainType{}
    |> ProductMainType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_main_type.

  ## Examples

      iex> update_product_main_type(product_main_type, %{field: new_value})
      {:ok, %ProductMainType{}}

      iex> update_product_main_type(product_main_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_main_type(%ProductMainType{} = product_main_type, attrs) do
    product_main_type
    |> ProductMainType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_main_type.

  ## Examples

      iex> delete_product_main_type(product_main_type)
      {:ok, %ProductMainType{}}

      iex> delete_product_main_type(product_main_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_main_type(%ProductMainType{} = product_main_type) do
    Repo.delete(product_main_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_main_type changes.

  ## Examples

      iex> change_product_main_type(product_main_type)
      %Ecto.Changeset{data: %ProductMainType{}}

  """
  def change_product_main_type(%ProductMainType{} = product_main_type, attrs \\ %{}) do
    ProductMainType.changeset(product_main_type, attrs)
  end
end
