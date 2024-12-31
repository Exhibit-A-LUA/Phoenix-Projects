defmodule DiabetesV1.UserAddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.UserAddresses` context.
  """

  @doc """
  Generate a user_address.
  """
  def user_address_fixture(attrs \\ %{}) do
    {:ok, user_address} =
      attrs
      |> Enum.into(%{

      })
      |> DiabetesV1.UserAddresses.create_user_address()

    user_address
  end
end
