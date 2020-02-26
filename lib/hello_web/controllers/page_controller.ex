defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"name" => name}) do
    render(conn, "show.html", name: name)
  end

  def render_name(conn, %{"name" => name}) do
    json(conn, %{name: name})
  end
end
