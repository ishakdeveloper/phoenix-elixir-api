defmodule ExJatlWeb.Api.V1.CollectionController do
  use ExJatlWeb, :controller

  alias ExJatl.Todos
  alias ExJatl.Todos.Collection

  action_fallback ExJatlWeb.FallbackController

  def index(conn, _params) do
    collections = Todos.list_collections()
    render(conn, "index.json", collections: collections)
  end

  def create(conn, collection_params) do
    with {:ok, %Collection{} = collection} <- Todos.create_collection(collection_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.collection_path(conn, :show, collection))
      |> render("show.json", collection: collection)
    end
  end

  def show(conn, %{"id" => id}) do
    collection = Todos.get_collection!(id)
    render(conn, "show.json", collection: collection)
  end

  def update(conn, collection_params) do
    id = collection_params["id"]
    collection = Todos.get_collection!(id)

    with {:ok, %Collection{} = collection} <- Todos.update_collection(collection, collection_params) do
      render(conn, "show.json", collection: collection)
    end
  end

  def delete(conn, %{"id" => id}) do
    collection = Todos.get_collection!(id)

    with {:ok, %Collection{}} <- Todos.delete_collection(collection) do
      send_resp(conn, :no_content, "")
    end
  end
end
