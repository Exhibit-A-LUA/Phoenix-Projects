defmodule DiabetesV1Web.MarkdownLive do
  use DiabetesV1Web, :live_view

  # Import the MarkdownComponent so you can use it in this LiveView
  import DiabetesV1Web.MarkdownComponent
  alias DiabetesV1.Accounts

  # Example mount function where current_user is assigned
  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    # Fetch the current user using the token from the session
    case Accounts.get_user_by_session_token(user_token) do
      nil ->
        # Redirect or show an error if user not found
        {:halt, redirect(socket, to: "/login")}

      user ->
        # Assign the user to the socket and proceed
        {:ok, assign(socket, :current_user, user)}
    end
  end

  def render(assigns) do
    ~H"""
    <h1>Technical Info</h1>
    <.markdown_component file="priv/static/notes.md" />
    """
  end
end
