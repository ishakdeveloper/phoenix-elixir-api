defmodule ExJatlWeb.Api.V1.TodoView do
  use ExJatlWeb, :view
  alias ExJatlWeb.Api.V1.TodoView
  import Phoenix.Pagination.JSON

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, TodoView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, TodoView, "todo.json")}

  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      title: todo.title,
      description: todo.description,
      completed: todo.completed}
  end
end
