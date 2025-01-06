defmodule FoodOptions.DietaryOptions do
  @moduledoc """
  The DietaryOptions context.
  """

  import Ecto.Query, warn: false
  alias FoodOptions.Repo

  alias FoodOptions.DietaryOptions.DietaryOption

  @doc """
  Returns the list of dietary_options.

  ## Examples

      iex> list_dietary_options()
      [%DietaryOption{}, ...]

  """
  def list_dietary_options do
    raise "TODO"
  end

  @doc """
  Gets a single dietary_option.

  Raises if the Dietary option does not exist.

  ## Examples

      iex> get_dietary_option!(123)
      %DietaryOption{}

  """
  def get_dietary_option!(id), do: raise("TODO")

  @doc """
  Creates a dietary_option.

  ## Examples

      iex> create_dietary_option(%{field: value})
      {:ok, %DietaryOption{}}

      iex> create_dietary_option(%{field: bad_value})
      {:error, ...}

  """

  # def create_dietary_option(attrs \\ %{}) do
  #   raise "TODO"
  # end

  @doc """
  Updates a dietary_option.

  ## Examples

      iex> update_dietary_option(dietary_option, %{field: new_value})
      {:ok, %DietaryOption{}}

      iex> update_dietary_option(dietary_option, %{field: bad_value})
      {:error, ...}

  """

  # def update_dietary_option(%DietaryOption{} = dietary_option, attrs) do
  #   raise "TODO"
  # end

  @doc """
  Deletes a DietaryOption.

  ## Examples

      iex> delete_dietary_option(dietary_option)
      {:ok, %DietaryOption{}}

      iex> delete_dietary_option(dietary_option)
      {:error, ...}

  """

  # def delete_dietary_option(%DietaryOption{} = dietary_option) do
  #   raise "TODO"
  # end

  @doc """
  Returns a data structure for tracking dietary_option changes.

  ## Examples

      iex> change_dietary_option(dietary_option)
      %Todo{...}

  """
  # def change_dietary_option(%DietaryOption{} = dietary_option, _attrs \\ %{}) do
  #   raise "TODO"
  # end
end
