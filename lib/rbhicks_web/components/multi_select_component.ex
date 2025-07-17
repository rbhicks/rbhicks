defmodule RbhicksWeb.MultiSelectComponent do
  @moduledoc false

  use Phoenix.LiveComponent

  alias RbhicksWeb.CoreComponents
  alias RbhicksWeb.MultiSelectComponentItem

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="border-2 rounded-sm border-zinc-300 mb-0">
        <.live_component module={MultiSelectComponentItem} id="wackadoo" />
      </div>
      <CoreComponents.input type="select" name="tags" options={[:ack, :oop, :zorg]} prompt="select tag(s)" value="" phx-change="tags-changed" phx-target={@myself} />
    </div>
    """
  end

  @impl true
  def handle_event("tags-changed", %{"tags" => newly_selected_tag}, %{assigns: %{tags: tags}} = socket) do    
    updated_tags = if not Enum.member?(tags, newly_selected_tag) and not (newly_selected_tag == "") do
      [newly_selected_tag|tags]
    else
      tags
    end
    send(self(), {:tags_changed, updated_tags})
    {
      :noreply,
      socket
      |> assign(:tags, updated_tags)
    }  
  end

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> assign(:tags, [])
    }
  end
end
