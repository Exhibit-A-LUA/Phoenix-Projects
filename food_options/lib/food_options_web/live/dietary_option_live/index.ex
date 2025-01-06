defmodule FoodOptionsWeb.DietaryOptionLive.Index do
  use FoodOptionsWeb, :live_view
  alias FoodOptions.DietaryOptionsHelper

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       options: DietaryOptionsHelper.available_options(),
       bitstring: 0,
       selected_options: []
     )}
  end

  @impl true
  def handle_event("convert_options", %{"options" => options}, socket) do
    selected_options = Map.keys(options || %{})
    bitstring_value = DietaryOptionsHelper.encode_options(selected_options)

    {:noreply,
     assign(socket,
       bitstring: bitstring_value,
       selected_options: selected_options
     )}
  end

  @impl true
  def handle_event("convert_bitstring", %{"bitstring" => bitstring_input}, socket) do
    bitstring_value = String.to_integer(bitstring_input)
    selected_options = DietaryOptionsHelper.decode_options(bitstring_value)

    {:noreply,
     assign(socket,
       bitstring: bitstring_value,
       selected_options: selected_options
     )}
  end
end
