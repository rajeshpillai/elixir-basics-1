defmodule TodoappWeb.PageController do
  use TodoappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
