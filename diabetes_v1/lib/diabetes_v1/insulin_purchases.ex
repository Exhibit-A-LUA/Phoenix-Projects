defmodule DiabetesV1.InsulinPurchases do
  @moduledoc """
  The InsulinPurchases context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.InsulinPurchases.InsulinPurchase

  @doc """
  Returns the list of insulin_purchases.

  ## Examples

      iex> list_insulin_purchases()
      [%InsulinPurchase{}, ...]

  """
  def list_insulin_purchases do
    Repo.all(InsulinPurchase)
  end

  @doc """
  Gets a single insulin_purchase.

  Raises `Ecto.NoResultsError` if the Insulin purchase does not exist.

  ## Examples

      iex> get_insulin_purchase!(123)
      %InsulinPurchase{}

      iex> get_insulin_purchase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_insulin_purchase!(id), do: Repo.get!(InsulinPurchase, id)

  @doc """
  Creates a insulin_purchase.

  ## Examples

      iex> create_insulin_purchase(%{field: value})
      {:ok, %InsulinPurchase{}}

      iex> create_insulin_purchase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_insulin_purchase(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:insulin_purchases)
    |> InsulinPurchase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a insulin_purchase.

  ## Examples

      iex> update_insulin_purchase(insulin_purchase, %{field: new_value})
      {:ok, %InsulinPurchase{}}

      iex> update_insulin_purchase(insulin_purchase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_insulin_purchase(%InsulinPurchase{} = insulin_purchase, attrs) do
    insulin_purchase
    |> InsulinPurchase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a insulin_purchase.

  ## Examples

      iex> delete_insulin_purchase(insulin_purchase)
      {:ok, %InsulinPurchase{}}

      iex> delete_insulin_purchase(insulin_purchase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_insulin_purchase(%InsulinPurchase{} = insulin_purchase) do
    Repo.delete(insulin_purchase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking insulin_purchase changes.

  ## Examples

      iex> change_insulin_purchase(insulin_purchase)
      %Ecto.Changeset{data: %InsulinPurchase{}}

  """
  def change_insulin_purchase(%InsulinPurchase{} = insulin_purchase, attrs \\ %{}) do
    InsulinPurchase.changeset(insulin_purchase, attrs)
  end
end
