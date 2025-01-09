defmodule DiabetesV1.InsulinPurchasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DiabetesV1.InsulinPurchases` context.
  """

  @doc """
  Generate a insulin_purchase.
  """
  def insulin_purchase_fixture(attrs \\ %{}) do
    {:ok, insulin_purchase} =
      attrs
      |> Enum.into(%{
        change_date: ~D[2025-01-08],
        comments: "some comments",
        fiasp_initial_doses_used: 42,
        fiasp_total_doses: 42,
        tresiba_initial_doses_used: 42,
        tresiba_total_doses: 42
      })
      |> DiabetesV1.InsulinPurchases.create_insulin_purchase()

    insulin_purchase
  end
end
