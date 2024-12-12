defmodule HelloWeb.LightLive do
  use HelloWeb, :live_view

  # mount - automatically called when a request comes into the router
  # here we define the initial state of the love view process
  # mount always returns a tuple {:ok, socket}
  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    {:ok, socket}
    # above is same as below
    # {:ok, assign(socket, brightness: 10)}
  end

  # render - renders the current state
  def render(assigns) do
    ~H"""
    <h1 class="text-blue-500 text-5xl font-bold text-center">Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width: #{@brightness}%"}>
          <%!-- NOTE assigns. can be replaced with @ --%>
          <%!-- <%= assigns.brightness %>% --%>
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
        Off
      </button>
      <button phx-click="down">
        Down
      </button>
      <button phx-click="up">
        Up
      </button>
      <button phx-click="on">
        On
      </button>
    </div>
    """
  end

  # handle_event
  # whenever a liveview state changes the render function is automatically invoked
  # with the newly updated state
  # handle_event must always return the tuple {:noreply, socket}
  def handle_event("on", _unsigned_params, socket) do
    # socket = assign(socket, brightness: 100)
    # these are equivalent but above allows us to add a keyword list, not just one
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("up", _unsigned_params, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("down", _unsigned_params, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("off", _unsigned_params, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end
end
