defmodule DiabetesV1.ProductAliases do
  @moduledoc """
  The ProductAliases context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.ProductAliases.ProductAlias

  @doc """
  Returns the list of product_aliases.

  ## Examples

      iex> list_product_aliases()
      [%ProductAlias{}, ...]

  """
  def list_product_aliases do
    Repo.all(ProductAlias)
  end

  @doc """
  Gets a single product_alias.

  Raises `Ecto.NoResultsError` if the Product alias does not exist.

  ## Examples

      iex> get_product_alias!(123)
      %ProductAlias{}

      iex> get_product_alias!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_alias!(id), do: Repo.get!(ProductAlias, id)

  @doc """
  Creates a product_alias.

  ## Examples

      iex> create_product_alias(%{field: value})
      {:ok, %ProductAlias{}}

      iex> create_product_alias(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_alias(attrs \\ %{}) do
    %ProductAlias{}
    |> ProductAlias.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_alias.

  ## Examples

      iex> update_product_alias(product_alias, %{field: new_value})
      {:ok, %ProductAlias{}}

      iex> update_product_alias(product_alias, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_alias(%ProductAlias{} = product_alias, attrs) do
    product_alias
    |> ProductAlias.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_alias.

  ## Examples

      iex> delete_product_alias(product_alias)
      {:ok, %ProductAlias{}}

      iex> delete_product_alias(product_alias)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_alias(%ProductAlias{} = product_alias) do
    Repo.delete(product_alias)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_alias changes.

  ## Examples

      iex> change_product_alias(product_alias)
      %Ecto.Changeset{data: %ProductAlias{}}

  """
  def change_product_alias(%ProductAlias{} = product_alias, attrs \\ %{}) do
    ProductAlias.changeset(product_alias, attrs)
  end
end
