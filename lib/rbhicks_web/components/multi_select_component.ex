defmodule RbhicksWeb.MultiSelectComponent do
  @moduledoc false

  use Phoenix.LiveComponent

  alias RbhicksWeb.CoreComponents
  
  def render(assigns) do
    ~H"""
    <div>
      <CoreComponents.input type="select" name="tags" options={[:ack, :oop, :zorg]} value="" />
    </div>
    """
  end
end
