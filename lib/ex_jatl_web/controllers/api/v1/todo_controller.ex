defmodule ExJatlWeb.Api.V1.TodoController do
  use ExJatlWeb, :controller

  alias ExJatl.Todos
  alias ExJatl.Todos.Todo

  action_fallback ExJatlWeb.FallbackController

  def index(conn, _params) do
    todos = Todos.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, todo_params) do
    with {:ok, %Todo{} = todo} <- Todos.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, todo_params) do
    try do      
      id = todo_params["id"]
      todo = Todos.get_todo!(id)
  
      with {:ok, %Todo{} = todo} <- Todos.update_todo(todo, todo_params) do
        render(conn, "show.json", todo: todo)
      end

    rescue
      Ecto.NoResultsError ->
      conn
      |> put_status(404)
      |> json(%{success: false, full_messages: ["Todo niet gevonden!"]})
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      todo = Todos.get_todo!(id)
      with {:ok, %Todo{}} <- Todos.delete_todo(todo) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError ->
      conn
      |> put_status(404)
      |> json(%{success: false, full_messages: ["Todo niet gevonden!"]})
    end
  end

  def search(conn, %{"search_query" => search_query}) do
    todos = Todos.search_todo(search_query)
    render(conn, "index.json", todos: todos)
  end

end
