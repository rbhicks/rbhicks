defmodule RbhicksWeb.MultiSelectComponentItem do
  @moduledoc false

  use Phoenix.LiveComponent

  alias RbhicksWeb.CoreComponents

  @impl true
  def render(assigns) do
    ~H"""
    """
  end

  # @impl true
  # def handle_event("", %{}, socket) do
  # end

  @impl true
  def mount(socket) do
    {:ok,
     socket
#     |> assign(:tags, [])
    }
  end
end
