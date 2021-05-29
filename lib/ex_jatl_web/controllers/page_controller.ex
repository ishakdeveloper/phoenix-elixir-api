defmodule ExJatlWeb.PageController do
    use ExJatlWeb, :controller

    def index(conn, _params) do
        text conn, "Main Page :)"
    end

end