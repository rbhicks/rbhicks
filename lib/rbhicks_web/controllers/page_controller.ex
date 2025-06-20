defmodule RbhicksWeb.PageController do
  use RbhicksWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
