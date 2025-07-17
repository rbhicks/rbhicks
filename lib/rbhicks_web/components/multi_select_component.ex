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
  def handle_event("tags-changed", params, socket) do
    "357filj1mdzsqlg6fhbcleu272ka1b" |> IO.puts
    "357filj1mdzsqlg6fhbcleu272ka1b" |> IO.puts
    "357filj1mdzsqlg6fhbcleu272ka1b" |> IO.puts
    params |> IO.inspect(limit: :infinity)
    "==============================" |> IO.puts
    socket |> IO.inspect(limit: :infinity)
    "6mugwcjfp4kpqd9wd5dgzhenod93a6" |> IO.puts
    "6mugwcjfp4kpqd9wd5dgzhenod93a6" |> IO.puts
    "6mugwcjfp4kpqd9wd5dgzhenod93a6" |> IO.puts
    {:noreply, socket}
  end
  
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:tags, [])
    }
  end
end
