defmodule FoodOptionsWeb.DietaryOptionLive.Show do
  use FoodOptionsWeb, :live_view

  alias FoodOptions.DietaryOptions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:dietary_option, DietaryOptions.get_dietary_option!(id))}
  end

  defp page_title(:show), do: "Show Dietary option"
  defp page_title(:edit), do: "Edit Dietary option"
end
