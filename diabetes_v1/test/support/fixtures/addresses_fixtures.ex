defmodule DiabetesV1.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        address_line1: "some address_line1",
        address_line2: "some address_line2",
        city: "some city",
        country: "some country",
        postal_code: "some postal_code",
        telephone: "some telephone"
      })
      |> DiabetesV1.Addresses.create_address()

    address
  end
end
