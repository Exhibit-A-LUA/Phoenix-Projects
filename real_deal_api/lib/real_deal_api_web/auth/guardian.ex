defmodule RealDealApiWeb.Auth.Guardian do
  # get access to guardian and name our project
  use Guardian, otp_app: :real_deal_api

  # include an alias so we have access to our accounts context file
  # this is what will insert and query the database accounts
  alias RealDealApi.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  # the subject from claims is pushed into variable id
  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      # if there is no account return error
      nil ->
        {:error, :unauthorized}

      # if there is an account validate the password
      account ->
        case validate_password(password, account.hash_password) do
          true -> create_token(account)
          false -> {:error, :unauthorized}
        end
    end
  end

  # attempts to match our password with the hashed password
  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  # generates token for this account - pass in the whole account object
  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)

    # once we get this we want to take our token and return it with our account so we have everything
    # create our own tuple
    {:ok, account, token}
  end

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
