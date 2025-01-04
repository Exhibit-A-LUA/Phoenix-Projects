defmodule DiabetesV1.Ingredients do
  @moduledoc """
  The Ingredients context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.Ingredients.Ingredient
  alias DiabetesV1.Products

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients do
    Repo.all(Ingredient)
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id), do: Repo.get!(Ingredient, id)

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    result =
      %Ingredient{}
      |> Ingredient.changeset(attrs)
      |> Repo.insert()

    # Update nutrition after insert
    case result do
      {:ok, ingredient} ->
        # Update nutrition after a successful insert
        Products.update_recipe_nutrition(ingredient.product_id)

      {:error, _changeset} ->
        :noop
    end

    result

    # %Ingredient{}
    # |> Ingredient.changeset(attrs)
    # |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    result =
      ingredient
      |> Ingredient.changeset(attrs)
      |> Repo.update()

    # Update nutrition after update
    case result do
      {:ok, ingredient} ->
        # Update nutrition after a successful insert
        Products.update_recipe_nutrition(ingredient.product_id)

      {:error, _changeset} ->
        :noop
    end

    result

    # ingredient
    # |> Ingredient.changeset(attrs)
    # |> Repo.update()
  end

  @doc """
  Deletes a ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    result = Repo.delete(ingredient)

    # Update nutrition after delete
    case result do
      {:ok, ingredient} ->
        # Update nutrition after a successful insert
        Products.update_recipe_nutrition(ingredient.product_id)

      {:error, _changeset} ->
        :noop
    end

    result

    # Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{data: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient, attrs \\ %{}) do
    Ingredient.changeset(ingredient, attrs)
  end
end
