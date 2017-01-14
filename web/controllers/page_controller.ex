defmodule SiBlog.PageController do
  use SiBlog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
