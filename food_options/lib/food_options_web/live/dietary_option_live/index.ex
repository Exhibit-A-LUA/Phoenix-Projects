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
  def handle_event("toggle_option", %{"option" => option}, socket) do
    selected_options =
      if option in socket.assigns.selected_options do
        socket.assigns.selected_options -- [option]
      else
        socket.assigns.selected_options ++ [option]
      end

    {:noreply, assign(socket, selected_options: selected_options)}
  end

  # @impl true
  # def handle_event("convert_options", %{"options" => options} = _params, socket) do
  #   selected_options = options || []
  #   bitstring_value = DietaryOptionsHelper.encode_options(selected_options)

  #   {:noreply,
  #    assign(socket,
  #      bitstring: bitstring_value,
  #      selected_options: selected_options
  #    )}
  # end

  @impl true
  def handle_event("convert_options", %{"options" => options}, socket) when is_list(options) do
    # If "options" exists and is a list
    selected_options = options
    bitstring_value = DietaryOptionsHelper.encode_options(selected_options)

    {:noreply,
     assign(socket,
       bitstring: bitstring_value,
       selected_options: selected_options
     )}
  end

  # Handle case where "options" key is missing entirely or is nil
  def handle_event("convert_options", _params, socket) do
    {:noreply,
     assign(socket,
       bitstring: 0,
       selected_options: []
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
