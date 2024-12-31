defmodule DiabetesV1.UserAddresses do
  @moduledoc """
  The UserAddresses context.
  """

  import Ecto.Query, warn: false
  alias DiabetesV1.Repo

  alias DiabetesV1.UserAddresses.UserAddress

  @doc """
  Returns the list of user_addresses.

  ## Examples

      iex> list_user_addresses()
      [%UserAddress{}, ...]

  """
  def list_user_addresses do
    Repo.all(UserAddress)
  end

  @doc """
  Gets a single user_address.

  Raises `Ecto.NoResultsError` if the User address does not exist.

  ## Examples

      iex> get_user_address!(123)
      %UserAddress{}

      iex> get_user_address!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_address!(id), do: Repo.get!(UserAddress, id)

  @doc """
  Creates a user_address.

  ## Examples

      iex> create_user_address(%{field: value})
      {:ok, %UserAddress{}}

      iex> create_user_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_address(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:user_addresses)
    |> UserAddress.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_address.

  ## Examples

      iex> update_user_address(user_address, %{field: new_value})
      {:ok, %UserAddress{}}

      iex> update_user_address(user_address, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_address(%UserAddress{} = user_address, attrs) do
    user_address
    |> UserAddress.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_address.

  ## Examples

      iex> delete_user_address(user_address)
      {:ok, %UserAddress{}}

      iex> delete_user_address(user_address)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_address(%UserAddress{} = user_address) do
    Repo.delete(user_address)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_address changes.

  ## Examples

      iex> change_user_address(user_address)
      %Ecto.Changeset{data: %UserAddress{}}

  """
  def change_user_address(%UserAddress{} = user_address, attrs \\ %{}) do
    UserAddress.changeset(user_address, attrs)
  end
end
