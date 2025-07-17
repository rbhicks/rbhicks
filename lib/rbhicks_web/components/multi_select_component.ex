defmodule RbhicksWeb.MultiSelectComponent do
  @moduledoc false

  use Phoenix.LiveComponent

  alias RbhicksWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <CoreComponents.input type="select" name="tags" options={[:ack, :oop, :zorg]} value="" phx-change="tags-changed" phx-target={@myself} />
    </div>
    """
  end

  @impl true
  def handle_event("tags-changed", %{"tags" => tags}, socket) do
    send(self(), {:tags_changed, tags})
    {:noreply, socket}
  end
  
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:tags, [])
    }
  end
end
