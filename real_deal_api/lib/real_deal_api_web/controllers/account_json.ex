defmodule RealDealApiWeb.AccountJSON do
  alias RealDealApi.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  # i added this because new phoenix doesn't have view to trying to figure it out
  def show(%{account: account, token: token}) do
    %{data: data(account, token)}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      hash_password: account.hash_password
    }
  end

  # i added this because new phoenix doesn't have view to trying to figure it out
  # SHOULDNT THIS BE BEFORE ABOVE FOR SAME REASON AS show FUNCTION
  defp data(%Account{} = account, token) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
