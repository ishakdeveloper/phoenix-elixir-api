defmodule ExJatl.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExJatl.Todos.Collection

  schema "todos" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false
    timestamps()

    belongs_to(:collection, Collection)
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :completed])
    |> validate_required([:title])
    |> assoc_constraint(:collection)
  end
end
