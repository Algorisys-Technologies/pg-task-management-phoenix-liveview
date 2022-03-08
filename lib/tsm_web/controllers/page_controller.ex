defmodule TsmWeb.PageController do
  use TsmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
