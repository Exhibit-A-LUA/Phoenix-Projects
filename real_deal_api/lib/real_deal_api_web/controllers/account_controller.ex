defmodule RealDealApiWeb.AccountController do
  use RealDealApiWeb, :controller

  alias RealDealApiWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias RealDealApi.{Accounts, Accounts.Account, Users, Users.User}

  # to call the is_authorized_account, so everytime update or delete is called
  # it will go through is_authorized_account plug first
  plug :is_authorized_account when action in [:update, :delete]

  action_fallback RealDealApiWeb.FallbackController

  # note both conn, _opts parameters are required to function as a plug

  defp is_authorized_account(conn, _opts) do
    # conn struct has a params and nested inside that is our account, save that to variable params
    %{params: %{"account" => params}} = conn
    # grab the account id and fetch the full account object from our db
    account = Accounts.get_account!(params["id"])
    # check that the session id matched the account id
    if conn.assigns.account.id == account.id do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(account),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      conn
      |> put_status(:created)
      |> render(:show, %{account: account, token: token})
    end
  end

  # is called with a sign in endpoint, conn is the connection object. => pushes value into variable. We're parsing
  # the json request in the function parameters
  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:show, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or Password Incorrect."
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"account" => account_params}) do
    account = Accounts.get_account!(account_params["id"])

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
