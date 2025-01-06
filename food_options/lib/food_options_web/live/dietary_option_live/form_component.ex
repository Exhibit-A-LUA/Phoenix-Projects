defmodule FoodOptionsWeb.DietaryOptionLive.FormComponent do
  use FoodOptionsWeb, :live_component

  alias FoodOptions.DietaryOptions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage dietary_option records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="dietary_option-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Dietary option</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{dietary_option: dietary_option} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(DietaryOptions.change_dietary_option(dietary_option))
     end)}
  end

  @impl true
  def handle_event("validate", %{"dietary_option" => dietary_option_params}, socket) do
    changeset = DietaryOptions.change_dietary_option(socket.assigns.dietary_option, dietary_option_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"dietary_option" => dietary_option_params}, socket) do
    save_dietary_option(socket, socket.assigns.action, dietary_option_params)
  end

  defp save_dietary_option(socket, :edit, dietary_option_params) do
    case DietaryOptions.update_dietary_option(socket.assigns.dietary_option, dietary_option_params) do
      {:ok, dietary_option} ->
        notify_parent({:saved, dietary_option})

        {:noreply,
         socket
         |> put_flash(:info, "Dietary option updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_dietary_option(socket, :new, dietary_option_params) do
    case DietaryOptions.create_dietary_option(dietary_option_params) do
      {:ok, dietary_option} ->
        notify_parent({:saved, dietary_option})

        {:noreply,
         socket
         |> put_flash(:info, "Dietary option created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
